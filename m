Return-Path: <linux-kernel+bounces-899962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B93BC592F0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46AAE4A1869
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27EB22727F3;
	Thu, 13 Nov 2025 17:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KeuNiak9"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877EE2F2914
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 17:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763054235; cv=none; b=WOV9Km744zlKtDRD7oPTQP+uv2z+8rN52sl9jHoT5gWBH+kZnk5/5LtYGVAi1aKju858oyV6tF7LY8KFnMzW6vhZJWalddWCQIsDWi+UqmrvValBkgiA6HhR4sCqVt1vfUq5QSVu9ecBmOOM03DPcMUa3mPwXlSRhDgBvV/ks/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763054235; c=relaxed/simple;
	bh=Zhz80cMnx8q+UfKEIXA1zXdhSkoVcxlOP4yVhENwo98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EwxtZ7CPCeki4kpTjTa3cNYnqJTm8Br3ZsaTfrSaWH3jtN9C2Fo4uNwO0oThD6eWVdXhJjI0GUMjsiC3wP4v+va5Td3U15tewnUq/Mt7X5jALcPazQ97FbTqhITUlDY4eyyarsGgQ17jpDzzz34sfecXXwb7iPV9x95ITXV13XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KeuNiak9; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-477632b0621so6946555e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 09:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763054232; x=1763659032; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M5KyfVieqHXba+u7m0lOAZosFkzUNJCY6nPeemJTYVw=;
        b=KeuNiak9sgzJ/vV+87wlKAvU8PeROUS37BNuZ1g3HKGUMFPg4G1gMy0qMpzJiLEnDk
         ZwS5Xog3MyXZU7t/HW3XSTfcZ+h9VMSe8gDvm4E8TsiDUBHNWgJWgdVuGCsQqBglSbMD
         JiUnropLIHHqKkrs/DlpD0hSM/auQ51OyPjXZtLpv5+6wg6yUvOcopD3N+f2GJuT15Ov
         vwZicy68xeAViw9m5IabG2NrUET90ieVWORe84d4L7vBOr3S5AtGeLJMNpsSxsxRP0Qb
         ymO+DVXJL7ghoZapeHuXnyOwu1B4ecOQq+oXw3entHz5UFDjjrbJ4m3XT4lFr4cI5xFC
         6Rcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763054232; x=1763659032;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M5KyfVieqHXba+u7m0lOAZosFkzUNJCY6nPeemJTYVw=;
        b=SZvj8bOHXAmTUW3yBrriSeIA23/ujY6mB2e5NJTIQ8RiC4RusPQG7PiA4g04petZEi
         HbNVhYS6Ph8yaMANX30FpQBYAhfWQ8w4QKbIhPDnzhyf40453DFvg3BEogumHEzagQAB
         +ATAoIVtxTuE2pIZuogGjA7qaM+gF0sTSCJ70sa5jmuqygNwyKNLFYV6p1mIAGalWbAb
         NXNrowOLjKzTG1NY0Rwa260HKagwnhF0rcaCpZ/A+dNhujP1Jvpr24XRUSOStL3nwgWj
         9rgeQpxnpzHcaTiI78P5lekHQWt8UDAIDonSW8NDUln4X6yrjajXiti9zNFGZB5RDAjU
         uWdA==
X-Forwarded-Encrypted: i=1; AJvYcCUc3dfyuYA7pzVoJLl9AWE/q+4xVQihXoWposuSxhHEVBHJ5kCxMPwi9UkA7WUN2rEA24QRvSwZ9sMUnms=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq/krGpkhVIiqvVVi2EQg8Y0I5cX/OhkH9N/rLOjcu/sju1rps
	mOkj6qsYSJewcqDQScH0iXlyfYmSiroe3E8mXdM+sNvXhBn3Va6OGPHQ
X-Gm-Gg: ASbGncvKoyCB+S5sTRKZUOPAXBpixamOVjPH/SdJmUYYUNe9u8VsYZDF4NxALoN+GeY
	EUgBFKblk004NK72XO1eGYWPerdONMhYaiHU0kYD+nFzW68ztwxjah8XokhgRmi24/6LE0IndUF
	Ec6Z9apbM3glDqPF4EGqk3Qvn2U++39R0EFdR3Cwu+Mw/Rde13DI0assRBtQivzH4LGeqJTU4vx
	7MGHgpwsodmRiXcdWiIbmtX1Bz8hB7NGsJnLb75ctZzQwTzSEoD3RQCjXfJ0wfgJQrOJSDU9aMQ
	fPdQv7vhzHPVpdHS6zDKuDWiwJvu1/EPnGh9gR8fZw5hkVPkwBGnRscVlDv4kY8UAUTA3MVZbcE
	P7Anj+7K0AP8RVtPMaiwwQHkJO1eHgrI9PAURNLWH/qt6mDMkCoXUbOwgSw3SmPCT0ZGsMIWZ8X
	3YKp0bbURwh4t5fzfTe8CRYCIk849w2hkIKl804J3NlGBX3hnXMH7UX3jDjBwcmXl9Q9VqjCgV7
	u0=
X-Google-Smtp-Source: AGHT+IHw0+dMsmHzK7SKkNNLgtvqsvSU9cN0flfGWOToSbXh1gwkLoXOxo+8crIR20brH6TmHylItQ==
X-Received: by 2002:a05:600c:450f:b0:46e:1abc:1811 with SMTP id 5b1f17b1804b1-4778fea51cemr2086535e9.27.1763054231540;
        Thu, 13 Nov 2025 09:17:11 -0800 (PST)
Received: from mail.gmail.com (2a01cb0889497e00f96f7d4f53fe5ba7.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:f96f:7d4f:53fe:5ba7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4778c847bbasm45065975e9.1.2025.11.13.09.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 09:17:10 -0800 (PST)
Date: Thu, 13 Nov 2025 18:17:08 +0100
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Cc: ast@kernel.org, m.shachnai@rutgers.edu, srinivas.narayana@rutgers.edu,
	santosh.nagarakatte@rutgers.edu,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/1] bpf, verifier: Detect empty intersection between
 tnum and ranges
Message-ID: <aRYSlGmmQM1kfF_b@mail.gmail.com>
References: <20251107192328.2190680-1-harishankar.vishwanathan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107192328.2190680-1-harishankar.vishwanathan@gmail.com>

On Fri, Nov 07, 2025 at 02:23:27PM -0500, Harishankar Vishwanathan wrote:
> This RFC introduces an algorithm called tnum_step that can be used to
> detect when a tnum and the range have an empty intersection. This can
> help the verifier avoid walking dead branches that lead to range
> invariant violations. I am sending this as a patchset to keep the
> motivation (this email) separate from the details of algorithm
> (following email).
> 
> Several fuzzing campaigns have reported programs that trigger "REG
> INVARIANTS VIOLATION" errors in the verifier [1, 2, 3, 4]. These
> invariant violations happen when the verifier refines register bounds in
> a branch that is actually dead. When reg_bounds_sync() attempts to
> update the tnum and the range in such a dead branch, it can produce
> inconsistent ranges, for example, a register state with umin > umax or
> var_off values incompatible with the range bounds.

I think an open question here is whether such patterns of tnum/ranges
happen in practice, outside of syzkaller. We probably don't want to
introduce additional logic for something that doesn't help "real"
programs. I'm happy to check the impact on Cilium for example, but that
would require a patch to actually start using the new tnum helper.

> 
> There is a solution is in the works by Eduard [5] to modify verifier's
> logic to use the fact that the register's tnum and range bounds are
> incompatible to detect that a branch cannot be taken. Detecting an empty
> intersection between the range and the tnum could be a useful primitive
> to detect incompatiblity.
> 
> * Detecting Empty Intersections

[...]

> * Usage in the verifier and next steps
> 
> The tnum_step() procedure is self-contained and can be incorporated
> as-is.
> 
> Regarding incorporating the range-tnum intersection test, as it
> stands, if is_branch_taken() cannot determine that a branch is dead,
> reg_set_min_max()->regs_refine_cond_op() are called to update the
> register bounds.
> 
> We can incorporate the range-tnum intersection test after the calls to
> regs_refine_cond_op() or the calls to reg_bounds_sync(). If there is no
> intersection between the ranges and the tnum, we are on a dead branch.

Couldn't we incorporate such a test in is_branch_taken() today?

> 
> Alternatively, the range-tnum intersection check could be incorporated
> as part of Eduard's upcoming patchset, which is expected to rework the
> logic in reg_set_min_max() and is_branch_taken().
> 
> Looking forward to hearing any feedback and suggestions.
> 
> [1] https://lore.kernel.org/bpf/aKWytdZ8mRegBE0H@mail.gmail.com/
> [2] https://lore.kernel.org/bpf/75b3af3d315d60c1c5bfc8e3929ac69bb57d5cea.1752099022.git.paul.chaignon@gmail.com/
> [3] https://lore.kernel.org/bpf/CACkBjsZen6AA1jXqgmA=uoZZJt5bLu+7Hz3nx3BrvLAP=CqGuA@mail.gmail.com/T/#e6604e4092656b192cf617c98f9a00b16c67aad87
> [4] https://lore.kernel.org/bpf/aPJZs5h7ihqOb-e6@mail.gmail.com/
> [5] https://lore.kernel.org/bpf/CAEf4BzY_f=iNKC2CVz-myfe_OERN9XWHiuNG6vng43-MXUAvSw@mail.gmail.com/
> 
> Harishankar Vishwanathan (1):
>   bpf, verifier: Introduce tnum_step to step through tnum's members
> 
>  include/linux/tnum.h |  3 ++-
>  kernel/bpf/tnum.c    | 52 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 54 insertions(+), 1 deletion(-)
> 
> -- 
> 2.45.2
> 

