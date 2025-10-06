Return-Path: <linux-kernel+bounces-843337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8497BBEF6D
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 20:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3DF33C570D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 18:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892E12D8768;
	Mon,  6 Oct 2025 18:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qfryP25j"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781602765D2
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 18:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759775392; cv=none; b=mrzKnJiGyOIRqQXfrjkRGJM5WbZdfU8WqDcMGU6jcXPaF3xZeZ2Vkvlt6d+ptQ0IuWbsH2ghIWNzxMbHmavuKPwEF9sw8tzx8zGI9t6N+OwVnoIjvfWExUMDzabezi0OvGciSvYQm875SDTAlBfSYxkEbzAZPst/OM7EIXMjld8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759775392; c=relaxed/simple;
	bh=lEUCz0wh4sAuRcJtFBfH3dwj0vBPWAu23W84Om7N6k8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IXEiza3R16Efwk1AHkJ3wpYMDg35hZxfV81ZerAsdFvDfqruXxRMcHa/OK0YxyCm5fGORZGO+6JE9FGMV048QSoWWi3sy0zRd+f2I7dI9bwaP73ufv7N34PLo2KUPygqs4TlNoGP8xNmAYWPVjGQ7igrvJeV10BRaWAYCZHWuIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qfryP25j; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b609c0f6522so8799728a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 11:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759775390; x=1760380190; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DGZDGjmGeCUm7mwBWDSr6hD8qwGcVBb+Gj+/oNuUrH8=;
        b=qfryP25j/MizitMdA+EjFyZxUkW1kNl0sr7uhFdFj4fhRC9rtHuONtH4QR+jNgXjXq
         c04vi1WalDW0xp23coSV6htib5fBADYLxhIotQk6tzAioCSn/Z1TKO9GOH/Woc3NHuJN
         t/+zUYo70X4vwoQ/eKNYa5QIG96mq7QHLqomcRhrESM7HegDM4l1PK/sNmvG0Gy2+GcD
         H3IEaTweznYCrRygDKsklhqoGWGX8xlynXbimkD4ZCopUwd7PKFdywIM/QQ8xMhSIqrS
         KFHFjC60eDQbmyNE8PaYWNLKUF/EbEm92PdS2+XU0vFrqd2VPENSxb14/zbCV85kEbik
         q2Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759775390; x=1760380190;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DGZDGjmGeCUm7mwBWDSr6hD8qwGcVBb+Gj+/oNuUrH8=;
        b=XnXtc7ueNKnjkmaae1bsk9SR/6Hg2eLkr6wrRMyyTvYITLLSdHx1y5j9knvF8/Yxok
         ujghtKxdw5ajVRInKVJMzXKxQZj/G9VQj8ilZanhMnJ5ohxWJVStmyYB7d3jA+TRWwKV
         djGRX1VPhV+1VNdsNP0S4vP5uqe75ZfYjM8KRW9X8169iH6rgyGyCr37VAECC41SflEz
         8Hjd53yNrOHpMftb3Hc7gxfNuibuZcJwig7tKMkqcBF5ikCi+CcVRXiRUS/GxTOf9wDu
         OyLQBLjkqA68pO8/WWZD4QUTb76FugIMtcgDH5oYSgWuoBW8yuPI9JgnGdNBE9tZ821l
         hAKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdisNfByT3H6EjwooHmlQwqD2KE6obr0YEymuQz3GJETqbitVfhsj0l+0XbTpvQwnfmTEFnDhh5bv1P9I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4c47jX1WP6AdMqZxqZXnZtisUBJthREexqMGowAp9HbX1G9nu
	W7sdxXl13Csky7t4rhHjYFP76xCZE7N5hD2wCPavh8YVOxLW2RD8/Qk++mGOgnWc2+azuLg/3iH
	0AEXDegh/a3BLDP6JJiLYXl0aLg==
X-Google-Smtp-Source: AGHT+IFioU/B/Ga27UIdU9h29h/Sxm4xW0dVRQ0dUX/shho+8jOks0koeYUqOHXTR1mlozQaDWCWxFDPvGR1+bQebQ==
X-Received: from pjm4.prod.google.com ([2002:a17:90b:2fc4:b0:330:7be2:9bdc])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1f89:b0:32e:d600:4fe9 with SMTP id 98e67ed59e1d1-339c2724b61mr16782674a91.4.1759775389749;
 Mon, 06 Oct 2025 11:29:49 -0700 (PDT)
Date: Mon, 06 Oct 2025 11:29:48 -0700
In-Reply-To: <20251003232606.4070510-8-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251003232606.4070510-1-seanjc@google.com> <20251003232606.4070510-8-seanjc@google.com>
Message-ID: <diqzv7krevdv.fsf@google.com>
Subject: Re: [PATCH v2 07/13] KVM: selftests: Create a new guest_memfd for
 each testcase
From: Ackerley Tng <ackerleytng@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Hildenbrand <david@redhat.com>, Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> Refactor the guest_memfd selftest to improve test isolation by creating a
> a new guest_memfd for each testcase.  Currently, the test reuses a single
> guest_memfd instance for all testcases, and thus creates dependencies
> between tests, e.g. not truncating folios from the guest_memfd instance
> at the end of a test could lead to unexpected results (see the PUNCH_HOLE
> purging that needs to done by in-flight the NUMA testcases[1]).
>
> Invoke each test via a macro wrapper to create and close a guest_memfd
> to cut down on the boilerplate copy+paste needed to create a test.
>
> Link: https://lore.kernel.org/all/20250827175247.83322-10-shivankg@amd.com
> Reported-by: Ackerley Tng <ackerleytng@google.com>

Reviewed-by: Ackerley Tng <ackerleytng@google.com>
Tested-by: Ackerley Tng <ackerleytng@google.com>

> Reviewed-by: Fuad Tabba <tabba@google.com>
> Tested-by: Fuad Tabba <tabba@google.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  .../testing/selftests/kvm/guest_memfd_test.c  | 31 ++++++++++---------
>  1 file changed, 16 insertions(+), 15 deletions(-)
>
> 
> [...snip...]
> 

