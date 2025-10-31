Return-Path: <linux-kernel+bounces-880644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 947B3C263F3
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 17:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5720424C22
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 16:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88062C2343;
	Fri, 31 Oct 2025 16:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TSS0uqVA"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF612EFDAD
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 16:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761929434; cv=none; b=DIuDBH5RLYwUqXSlz7U1XUluYnw97ISMQAbevNY9W8ErpwcHMnnZIwKd2Am2tfuLIvV8/PMAqgxwftkRYn29hQLAWNBsUThUPhOzdF8Jclf0YLM0IFkXdO23+mpdb9YNdZUAplbw8nxyFWUU0shNSk/olgLVvQE/LCzHdG7vkYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761929434; c=relaxed/simple;
	bh=CkTc3uqUV4oAWU25vKzur3uX0jgjdH9NEyqWGZX2ofM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gC5ubLma/nhEMNrq9fn3sBkkxnR6NPUrHJUB30cODtzoYj91MLNZe4AFr/p+l7+pBEkThZ+nZJpWj1lxARCfeOKyNXmci6JC77yO+foo5Qn7DmCTBuRKlaaHuqW5hJYwLV3NtWVwCTwJfFH5MHoGcHk2ly7LFhly/hUAdYGnfnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TSS0uqVA; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-375eff817a3so29838411fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 09:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761929430; x=1762534230; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HECjj7h2ccCzw3YUDexJtN/DN7YGJtXB8c7kq1Ybt8w=;
        b=TSS0uqVAgglLe5OBHsXx4Xwp88Tr8auE90Zf6D0y/NTmlq795OW7U+XmEj5ofTI4uV
         IV+1FUXQZLxixWWsW20yremn4kZrWHgFUHSAJdM1gnGBJS7kTRLB1kve8hHCErFOxu3i
         IKM6ogLi92qfHYe5+xUmbJONVXGk1F3zPJbjOfALZtYEVOLV5clHr6Si37IMEamSlhb2
         miMznn7Jp8P9p8H7A+0qbnlOQv9NXJApcgU6564Hfn+8XC9IXp0qk0pGvpI5xSckrsS3
         pfngGuT1SCbwAvW0MpAIOGMyF1BYafZ19Nc34xJ7HyFztuYbK4f6r4fparsFouCMumbt
         ndaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761929430; x=1762534230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HECjj7h2ccCzw3YUDexJtN/DN7YGJtXB8c7kq1Ybt8w=;
        b=GS4g1wnA1XKhOmHHpYPzz4sNqZkXDoOBsZk2vYC3W0qSLl2lH/NoA0nIToNCa85noE
         /UU9WLj8TzEqDgXgxqBYOPvF9ysoASFBjyiSPY/CvQg5z8LMSWqIYJi3Jix3YUYXSPBZ
         QyQ6tzpMDuAbyJEiaYFbnQhH36x4Fss6maGDxv9uwfs/7brqD3qpfoZCG83CUDREDG90
         CnS7sJFsLtL5YmP8uQ5uwtqXbcPUVLPIIfF+2l13OHL30G22RAEz1kd8RUclWUWA1BDb
         0VWD46uPTNxphqeukK+ywxoKr05403Vg0/Exhpn50l0hHEIEngJD9NfpZCeX/omDlCgr
         blaA==
X-Gm-Message-State: AOJu0YyhqxXEMyJjcxlIIbLWGGbpyKtD3pgK887wXsMdR5EY4C7VOV4p
	bAOwlKleaOke6yT9FZnj8UDC5VmDsCfiGBmM+llNMz2VFOgUkGL8BxWyds6zo3VNEiOJhbtU9AR
	+WV1/74aHuIUGosuvZt0X2m3ieKg4+/BIkEv4whnFkQ==
X-Gm-Gg: ASbGncvcSKxBERytk7SSj2Aid819CrkNnHfYKld4ABMEZO/L1lDLU+SZYQIAs5/IZF3
	IS9uXNJZQHdWyiN75ij7X2a3ZqVIorXmP0aOwY3AaVULtN6F0o6DR0lNOkFBFV3NL8fLVhWmbdJ
	VeBJwW7dsU1eMnGRWLQ+l5UKnrjU3TGUv45iamDMkAhsj8Ve/B3DAFN8w8aATIhkndJMFbwC/Mp
	zT9ionLrkiUmiN4v3eKdoSxisglxza/xopD5msPKHtSh32B/sq2YX4wDM6Yjm3PRM4gI3yOZITL
	pP7jERUANoZ64VeXsg==
X-Google-Smtp-Source: AGHT+IHNkQkcVReeJSmIh2XeLdh1w6k92Iktx8NubjHPcdvXGpM8QNJ8YlcYkfCdWLOlRt0JgryZEzVytwgIdb8m41o=
X-Received: by 2002:a05:6512:3b89:b0:592:fa1b:a952 with SMTP id
 2adb3069b0e04-5941d54f494mr1593682e87.49.1761929430131; Fri, 31 Oct 2025
 09:50:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030163839.307752-1-marco.crivellari@suse.com> <6904cc6cb4123_23741210067@iweiny-mobl.notmuch>
In-Reply-To: <6904cc6cb4123_23741210067@iweiny-mobl.notmuch>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Fri, 31 Oct 2025 17:50:19 +0100
X-Gm-Features: AWmQ_bls58IN4Jraq6j6gpOUUrBCJuzYEiIJWhONPPwjCeljWuU0Ihmpll3Qlq8
Message-ID: <CAAofZF48WB10W-wQtUAOghBvBAQEc9bkJqKLir7Qzr4pkhLOWQ@mail.gmail.com>
Subject: Re: [PATCH] cxl/pci: replace use of system_wq with system_percpu_wq
To: Ira Weiny <ira.weiny@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Davidlohr Bueso <dave@stgolabs.net>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, 
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 3:47=E2=80=AFPM Ira Weiny <ira.weiny@intel.com> wro=
te:
>[...]
> A reference to:
>
> commit 128ea9f6ccfb6960293ae4212f4f97165e42222d
> Author: Marco Crivellari <marco.crivellari@suse.com>
> Date:   Sat Jun 14 15:35:29 2025 +0200
>
>     workqueue: Add system_percpu_wq and system_dfl_wq
>
> ...
>
> Would have been nice just to save reviewers time.  Regardless.
>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>

Many thanks, and sorry for the trouble!


--

Marco Crivellari

L3 Support Engineer, Technology & Product

