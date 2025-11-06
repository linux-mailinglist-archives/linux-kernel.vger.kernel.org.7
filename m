Return-Path: <linux-kernel+bounces-888075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 676C7C39C7D
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 10:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97EAE188AF86
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 09:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD3E303CAB;
	Thu,  6 Nov 2025 09:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OVGAPDYU"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FE626B95B
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 09:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762420653; cv=none; b=C9thkDmGMQxZ3IbHfq82QaMTlPD0s5gibMkNFSz+rJFtO6tRq1WNUmgtVkfKyPX0YG/sZ4/ODttQiPt/Z71up8rS5Xr6IkRq6iLK1xUm0MYXzdhDnSx6OKooyGWzP7nsyUgvUwMdgbKiSn1m88rW0OrpQQyQFKV7yBgeMK7TYgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762420653; c=relaxed/simple;
	bh=h+z+1A5u4C64dFdqyznJ2FIRrcH9CONAjEw5abNXjfY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R3Er4Lt7vuGKssxtwvCiKVfdfYnhl6oAe33EJOChuu1a0K1HuwcSVarCCWdPcPszPGCwywODtMScAPQc5kVMDUCTCUKDD1fQWMfGazhZB+HF0Pagg/WHqGbQ3y9PhEu3C9Cz7WOWq63zTgJmo29tabucz/PvOyy8/xTzPMRxb40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OVGAPDYU; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-37a2dced861so18053961fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 01:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762420650; x=1763025450; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h+z+1A5u4C64dFdqyznJ2FIRrcH9CONAjEw5abNXjfY=;
        b=OVGAPDYUxzGBXPtiUePPQX77Skiu8GJoWzZSf06Tn8MXxvNRAjzRY5aydVUdfEdBF2
         8YRYep9Hi41vVS3Ys4epuw+Er6vsU3/aDFugHnKLeb0avU6yvcYoRy27ehe6H5BVOlE7
         GBz2TPtZ01pZrfRe9MHxrTsVPTQN2NWEQgg+NSDQSgdjFEVz0qgSepI9xEZTqYsCCHWF
         V3zuoyHDarF7vxkxUbF6EKpmKW/KUQBD232sPuUwkPjeYesCiOy9QhgBFRJXjt3pYlVH
         D3eUxiUfgIfQi6oEWImQJBXJ702YJT2v971wSX6yPRUKMRFSMtLnK6ljUzVaDiBHDdO9
         viLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762420650; x=1763025450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h+z+1A5u4C64dFdqyznJ2FIRrcH9CONAjEw5abNXjfY=;
        b=M+fbM7MQyMCNN2yclM41FQ/NbhuZtmeolMZlry8sbzVvppYBVCOyuRbhGh/ss0DuB3
         VH5VFMUAlaA1f+iQLPX4duVvuH9ewVqivGy7LtSFLgSehJ9BiaChXZLhL43UN1Ky7HWE
         dIXlK52/OKnjL0JzKvH0a9IXovsTy6HG0R13YpyO2L8rMp0dYuYEx25uVhS4otFaTs/S
         jIIHjwO1Lznj7A8KyFCzTy1G41/8NtkbmtBsaflIkD3cpmVtnNXV0a6LkLTXWsr3pspm
         pm9T3VUTPNxmh3m1jhKiVGR2WBk2D+Gb1rpqUDC6ZHOSUwvu9H80AcihP2dKcxxLJUDY
         8opw==
X-Gm-Message-State: AOJu0Yx7SN66UtpOwAYAcMDXSjiuYU8I7DE67+Qf101ccq3OsOHFxKLo
	jtQhSVv3TQb+vIFYeghKGgLWNQSTkJ9d93vcvvt3DqZXKKvlCsizJlz+Gf3Zk/vh2dyQjvvG2vO
	EzTbm8qUwCzVHxzkOduklzjsLLomqrTfv8ezMps6kTQ==
X-Gm-Gg: ASbGnctxWdxuYvWgIiVzUi16WMFFBjDDXvWlk8qwH0wN1B+x28xzJ5jIAzNUo/Uyev7
	ljUGoKXUjlPGW1GI+bfbgRbaS3n+YAuPr7Ie5LbNkS+YumnNpLlPPP4MT24+75wmPkPonUCzKB5
	2NdQ9GwACFfUsDxOo17YDnl4rFOPuz33u/BLJjs+xeV2vAcW2PT5qpFMn3Up7F3TOCxxjELosKu
	4eobgxUch0we8v/n8rimEK/j+bsEEpvth7ke3Rux26xR0GF5jI0jqQB7lCTRTkv7VBiMi7sJ/JF
	zq+CsGCMnvs9DhToOA==
X-Google-Smtp-Source: AGHT+IF7c3FwP32os7g5g3nnhez/YGj7H7f6SIZxDU5kfQ8IXpiNDCY1vtNVgOkbueh7+ta7vJxNffCoSjVaHg45kvo=
X-Received: by 2002:a05:6512:33cd:b0:594:2f72:2f89 with SMTP id
 2adb3069b0e04-5944931cd2dmr762954e87.9.1762420649935; Thu, 06 Nov 2025
 01:17:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105160819.302988-1-marco.crivellari@suse.com>
 <20251105162932.GAaQt7bON4FtSmxQ3Z@fat_crate.local> <CAAofZF4fBbFtiKxde2M2ikK4k-LqYVRoavPbNVh-XFiQPmfGvw@mail.gmail.com>
 <20251105210800.GCaQu8sKCjZ9Xcq8-n@fat_crate.local>
In-Reply-To: <20251105210800.GCaQu8sKCjZ9Xcq8-n@fat_crate.local>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Thu, 6 Nov 2025 10:17:18 +0100
X-Gm-Features: AWmQ_bmcyOKjGadcgDMVTcigTKt7NE2VAzo9CGC8_ABY9cTLzN8m_BWUJEhFcDU
Message-ID: <CAAofZF4Sdk0REJFearcrB5_MLLQZWaNpecUPV0+BOiNcvmTaWA@mail.gmail.com>
Subject: Re: [PATCH] RAS/CEC: replace use of system_wq with system_percpu_wq
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 10:08=E2=80=AFPM Borislav Petkov <bp@alien8.de> wrot=
e:
> On Wed, Nov 05, 2025 at 05:55:49PM +0100, Marco Crivellari wrote:
> > The code is using system_wq, this is the per-cpu workqueue. This change=
 will
> > only replace system_wq with system_percpu_wq. So the behavior is the sa=
me as
> > before.
>
> What does that mean?
>
> We're going away from system_wq in favor or system_percpu_wq? Or?
>


It's just a "rename" from system_wq to system_percpu_wq.
system_percpu_wq is a per-cpu workqueue, exactly as system_wq.

But in a few release cycles system_wq will be removed from the code.

If you want to have more details, you can read this discussion:

https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de/

> It is not clear to me what the issue is what the new correct way should b=
e...

There is no issue, except that system_wq will be removed. In order to
achieve the same result as system_wq, the correct workqueue to use
is system_percpu_wq.

As you can see from:

commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")

system_percpu_wq is defined as a per-cpu workqueue, exactly as system_wq.

Thanks!

--=20

Marco Crivellari

L3 Support Engineer, Technology & Product

