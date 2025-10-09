Return-Path: <linux-kernel+bounces-847538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 580B7BCB21D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 00:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58FFF3B3468
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 22:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC2C286D5C;
	Thu,  9 Oct 2025 22:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d7y0mR3B"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8531D2836A3
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 22:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760049856; cv=none; b=snkf0a4F/pgQKYE7+S28KR7hZCO9M23OjiZwwJ1Ju59uHN25oUyuEzJS5VlKXWicgpzUNuqlU7fI24V/Uur0r1Hviyr7A+PazggzPfmhupewdjTs4DxGrtBxoRrH/6dQnYHaw7wlyFca/qi0qrfNMV2eyV7aQrsGyvEX9qxBU6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760049856; c=relaxed/simple;
	bh=/ZQV7MCAtGcsYl1ytfZ6Hxd7JHW+2Q4tq8mrY8dcDm8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pzfOZt3Sy7T0Tmk4QzqB4lqGOraNP30fG8HLj7DYsr8pk/Bfxle58/nJTnok1SVaCfGK2rxRZHEZ3Q98QlxMog6Qw9GmNEqjXfh1W2yUBIMc6/uaxVWwlfdPY4SWBAWU1QVxRC6/0EDdi7kYlLYYK+NaeBjAR8cCrveAFnZHzhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d7y0mR3B; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-62fa84c6916so5493a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 15:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760049853; x=1760654653; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ZQV7MCAtGcsYl1ytfZ6Hxd7JHW+2Q4tq8mrY8dcDm8=;
        b=d7y0mR3B6B0A9xv/8aItygjU2qaio3rD73URwheajADdbyJclvtW3DWTq3aVoov+1+
         IMMUvfFFHEedHlhYR/GuCrLCRc4ICoOgU6WpSr6zHgcWsZ84Zfm25txcImNrZH5C+dnW
         y6delvjZTItIP3m33kcJeCA2j57utWumQ9WQQh0Lshgaxw4fZQlkQJa8L6Z4noYnWO7o
         bdG+0Iti9PwoHWOvWpPv73GSpEMrw4o24Q2oXSkkU/zXqckXO9plG66mu23YJzPGnTkG
         OxZo5y4sqiF5Z1sbz7/byKYuFGwEH14vsfLPiIHXHQyVYABbZoLHB3Rb9b0Q7lUqWEqm
         +8TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760049853; x=1760654653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ZQV7MCAtGcsYl1ytfZ6Hxd7JHW+2Q4tq8mrY8dcDm8=;
        b=nql8GcoQTf8lVAxkDZHxv9UBGd7XWJ5GPRD6tJAAxF2KRSXNWg5xz77vqTrP7BeCr/
         PR5KiDDS+f9MiRtFh+8+uPErxzjXzyxxPRu2aJr2fdQ6hs8SPu2P60GnTdeH3qECgnL3
         Ozcm1KkeedaxCmvF3mEEMmJcpO1578s/lVQheXYyv2RkBKryDOvvL4rJ5KjaOY+N3+w8
         7MAyfcZx9OgpnGSrHVQjcMohi5JAUTiZVcVKWaw8nGWa3maKxWvuthpdWGlAWTfEH6oL
         waJ6uzwc6DmfKoHNicAa1yuKM9By2ExLqdhSNkxYQcXrsLcMk6WJAR7xhvij5ZFzqrRw
         CkVQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1WcBAWRndbQWrpLRqmJ4GssHdZgsgRHMxjIl3ArzocHK0qlLZTJbeqN5sUKHUfZDlvpgc1J3eIj2MgUs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoUuHe4ey5kHttxFb3ibIJE0GTKHeUGLBRsljXdteWxlEMgO+g
	zB6ZefQH/1Etx3y9uF0ypoSugcWm5bPvD/e5hEvSRykiQKU3fHV8QteiXiRCscfxup/ftUEgK9F
	GLa153a6KsiP+BTCF2FlqkvYo2QU8shpg0FhpydUl
X-Gm-Gg: ASbGncu7OoTWcayFkKlhDSutMuaDf7RkegmkSCutujETkPhPeMX3EJYkB5faQ+PcDxb
	xTTfsJSI4s5uwdmw3JlhaVfSO2Bj5DFNMI8k+Q3frWlDAl1w6nMUTvmgUY+fh7gs96lNVz5Th/B
	dMLbkTRlKJ5KUcN7MisOoz7Ox5xSngMTY8mLa5ns6S81rVqsxTGXlM7QD55lW3mB9PcObBQK8fa
	X6FVduQ/HBxHpihtlEpvcCgdQ6Knng8c3DSbQ==
X-Google-Smtp-Source: AGHT+IEnFMZwLjS7zK4kzP+SLlOtqLFUsfvGqhS92wvgvhipMcxe/qc+nU5JiV4CuYZnk+5YoAH4Vp1mN3TSa86Oi6k=
X-Received: by 2002:a05:6402:6c1:b0:639:da2b:69de with SMTP id
 4fb4d7f45d1cf-639da2b6b6dmr279914a12.3.1760049852720; Thu, 09 Oct 2025
 15:44:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001145816.1414855-1-yosry.ahmed@linux.dev> <20251001145816.1414855-4-yosry.ahmed@linux.dev>
In-Reply-To: <20251001145816.1414855-4-yosry.ahmed@linux.dev>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 9 Oct 2025 15:44:00 -0700
X-Gm-Features: AS18NWAHeekPlDWhplvq5MC0GC5HvwXC-Om8NTx83NXyQCIW4DVqCcUZA_gr-so
Message-ID: <CALMp9eRN-4ndzDo1oBexmPfv1rJORfqO=kxKVJeX7De1H8BZBQ@mail.gmail.com>
Subject: Re: [PATCH 03/12] KVM: selftests: Extend vmx_close_while_nested_test
 to cover SVM
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025 at 8:01=E2=80=AFAM Yosry Ahmed <yosry.ahmed@linux.dev> =
wrote:
>
> From: Yosry Ahmed <yosryahmed@google.com>
>
> Add SVM L1 code to run the nested guest, and allow the test to run with
> SVM as well as VMX.
>
> Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>

Reviewed-by: Jim Mattson <jmattson@google.com>

