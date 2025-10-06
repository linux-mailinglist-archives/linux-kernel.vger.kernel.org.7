Return-Path: <linux-kernel+bounces-843391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 96082BBF166
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 21:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1FE0534B287
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 19:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4CC2DD5EB;
	Mon,  6 Oct 2025 19:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mYB/1Hwk"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEA72641C6
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 19:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759778696; cv=none; b=iv7wGV643yOBMIDGNpQkMmd9UcXnkZpIxRtUC5mZUl4kpw8nb+yNgerQ9sjrbl/K4kyCNTTsJOMLw8XZVtyLGUGgdtFVDPhgkqWsFusTf0aeK7YaPcGOd+Wccxm1ZvY8LGkXCfw2uYbzuBKkAUchrqaCOEP+0tNJrk14Q5FcxHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759778696; c=relaxed/simple;
	bh=gzzvKnF6qJ7lJudLs/+S8tBn4LMDyPLqXA/nMHePsSc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lSwpbyPnrOTfEcF6QV1qc34/GfC+E6mGhW9MBNiwZTmfqEmhWf2bMSGIESwXNCtm54vbsR2IJUgvewCHayYhikiDlt/32DsCaf/oLt2nhRxYIJ/ar4O/pjt6qKUSON8m8RB9xc0T7VkXI1giyMsIKM7BQBW1kTqYv6WhCzQSeAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mYB/1Hwk; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-77f2466eeb5so4948693b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 12:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759778694; x=1760383494; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MwCv/q5RLrOVP5H2/mUJFVpJKUB0tJIPOkj23AFdbos=;
        b=mYB/1Hwk5/djOTQkZojycRPAJ17J8MkN12THO24D6IxGz4uHfoLTEQZ6OE3cvFtbfP
         b4p2Ak4Dyc40UZKmkrqy7vXWJB6ce5yn+nW0ASQI4fRFEd4pZEdFnFuOkWawfqCzWdNj
         ciVjSDyM0vZ0IfpZezELznHeQkRtEWiKbBF4t9supT4HdBEOEeNyhAjryPJZEst6epx3
         6NV95NWGlQv2Nk9FrTr9wog3LXU215QcdMy0rS7YGnJdO4eBM5iUqfN2JegLVbRPIXHH
         NyAwGajYxqvkVCIsU4YCzepF3+y7AUNzIMg+Smz/daP2EXH0QaXL+oVnUTM4v1UWYvMo
         sENA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759778694; x=1760383494;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MwCv/q5RLrOVP5H2/mUJFVpJKUB0tJIPOkj23AFdbos=;
        b=Y9dakegKdzenRppw7oOpmKqBU2Kr+rIE2WQfBYKdlCyFT3H6hH+zxq4RK+dLJPrkOh
         bTn0Z6wMS0f/3rLTwu5j1cci8/6TGnNnovgXf4e1lWeh2bypIUNlYzH+nHWSvf3Xr+Yq
         t4fUkXM7MZITwhY8YlzTFT1sa6vm7ovDmT0dtMMn0PSHZNW2LcagtmCn0jRuHM6u5ko3
         XJhaT/Q1jH9fXyl/DU39/P6+pkkqYI6nbIXZjhE1J0r47SSMSgfepoEW9OMtVOHTmzyW
         MzB+pp9AUvhFqSrLs+rLK/jdkjSuJoEBK7vCmbgx9s3GUBcGJdr2LgME8GaNnS7lmI0+
         ndpg==
X-Forwarded-Encrypted: i=1; AJvYcCWeVia2plzIsG8xhXgOTfJ/2u5jIMvLJV4HzijtF1PW67733jCnWgkYjJ93xsj3sagfhwIDOX3YbHLiP8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF1Ngzw1qhpDdUvbZM/m8novTJXypWatbOY8w9dOG1sBQQg/Vi
	Xs4LZnV44f6QOERAzL+RHndhPzps6C3OIrKo2PlrwaJOHLYS1aHTJjuwT3VKNA4898mso4SqGun
	E+ANyLg==
X-Google-Smtp-Source: AGHT+IHiIsra+i6pzpFSJKTUcR3R1ZEtEd8CiGXaiveuskEqCtWdUdLIj7ydtiLIe9mDGjYusezaU4r2um0=
X-Received: from pgbdo10.prod.google.com ([2002:a05:6a02:e8a:b0:b5f:5359:4b92])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:e290:b0:2c2:626b:b052
 with SMTP id adf61e73a8af0-32b6209da14mr18587401637.38.1759778693902; Mon, 06
 Oct 2025 12:24:53 -0700 (PDT)
Date: Mon, 6 Oct 2025 12:24:52 -0700
In-Reply-To: <diqz5xcrgaa5.fsf@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251003232606.4070510-1-seanjc@google.com> <20251003232606.4070510-14-seanjc@google.com>
 <diqz5xcrgaa5.fsf@google.com>
Message-ID: <aOQXhJyTXHt8Kw7F@google.com>
Subject: Re: [PATCH v2 13/13] KVM: selftests: Verify that reads to
 inaccessible guest_memfd VMAs SIGBUS
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>, 
	Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Oct 06, 2025, Ackerley Tng wrote:
> Sean Christopherson <seanjc@google.com> writes:
> 
> > Expand the guest_memfd negative testcases for overflow and MAP_PRIVATE to
> > verify that reads to inaccessible memory also get a SIGBUS.
> >
> > Opportunistically fix the write path to use the "val" instead of hardcoding
> > the literal value a second time, and to use TEST_FAIL(...) instead of
> > TEST_ASSERT(false, ...).
> >
> 
> The change the use "val" isn't in this patch, and I think the
> TEST_FAIL() change was intended for another earlier patch.

Yep.  I originally had the TEST_ASSERT => TEST_FAIL change in this patch, and
forgot all about the changelog when I added the SIGBUS "catch".

Thanks!

