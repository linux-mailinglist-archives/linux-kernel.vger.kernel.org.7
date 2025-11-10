Return-Path: <linux-kernel+bounces-892780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CF5C45CEC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6B0894EF852
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E68302CBA;
	Mon, 10 Nov 2025 10:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cXuvcRLO"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A30302164
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 10:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762768816; cv=none; b=tuQV+7EeWcUfGpNEPxN7HS7GP2sBBSYyDZitOGJt9mpNa3gJ+miYVTVKpXswje/bnTAFnrQAJHD3X1g3HGg2SWO+4Lz8s/R+GoJyKEjuVRFoIBfhixT7vH4FGW/f3dZ+jfSf4ydQBuINngZL+QgZcZIRrNxAbrRO/3boKjSZYQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762768816; c=relaxed/simple;
	bh=5Rij/2CviNlBvh7WHWIbSwpeQ5DLytBhS65BWZYZRHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=all/h3jUsk29nJN6reNgGC9l0D9JgfGpAJjJzhoIZAEYLpY/dD/H3U4NULNrzXyVLzep1z83GQjWPWh2M4SFnqjW19YzgeRkHpAD5otJN0NTmmKt4Vn9sFRW96U7lDSEdxAVKi2MoJJiRFWHgujgCxScByPpx7ZQxhdE/ej69AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cXuvcRLO; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-594516d941cso3036489e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 02:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762768812; x=1763373612; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Rij/2CviNlBvh7WHWIbSwpeQ5DLytBhS65BWZYZRHU=;
        b=cXuvcRLO7hIVHuNZB800UQVwbQ9EScKJULlYegscC5Dac+ke8/jJpYE8JrSSOeJ2Lx
         oSSK7gHKuaV2Zl3rq9Aoembv577k7mkMv/A2tSHKqdzXqCKY6cdbmTu1AvBF/gGfF0+9
         VtXZ5jMX42kt7UZWyHtimghf+h3H66LK03briXMR651GiOcoQzyHG3h980BuqG31iddY
         bJdYOL1TZWFmvqkUPTqQ9XlaUg8ESu0yQI9nkyE0dBBxsysuTcEK3luVRjmm+8Zy0udO
         9A0U2k949YkQmigR1VNmg9dQ6zk0+Bo4+7PQlFdwVeByxfnMUGyZKPb9VN20vImUmZt8
         hQ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762768812; x=1763373612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5Rij/2CviNlBvh7WHWIbSwpeQ5DLytBhS65BWZYZRHU=;
        b=PCursU/6BQhxpgT0hOpXTPVsj5mgo30uKSDGy371qIAppAJf2dCmooUG4FCrT3tOuF
         0fpF3QiB6ycqCFXa4eLm2f/cgB0jAm2Pu7sj5gVkMVrgyc06dbcvGeqWZJDW9mk8+VHi
         Hlr4ibueXWaKa2JXRQTCBCEl/usnPznTqKcM5ki79fe+54c1XZnmLPDkGf3zxDlolvoN
         CqC5L095L0OMxp5ix0sVtgKEQ6m+ghLAiZQzFluZpwzChDRszW8dkK3+r2TlRGZlYhzp
         J3ZOH3xRzQLCbdhFMWJT08bz3zVo7UV7cXlFX4JY+Gk4AZLcXWfjRftnz6RsbFAUwno6
         tNng==
X-Gm-Message-State: AOJu0Yy2GgJULLSO6DmIHE2afPYknjqViPcFDEfGJmiEry4zirxbcSOl
	faTLkG9l7DqCOeuDpXTYT2QGwK4d70B4AjLPnsbk9vpKvMcO6crVuzLwfYTJPQtyQjEigMil9iq
	dZBftW8KGGVMtyUDYLBQ8FG05SQqQcpSZzK9Xn1YPGw==
X-Gm-Gg: ASbGncvrEoERVp+5/lPkqfbGmuaTR5IJ2gEEob7BHj5BPwy/LM1C8dEcibEHsHYyCqI
	U2iPhidUFVyHPnqBxjkzg6QVZcbY0n5IQy+scKoL3IKXqX1gTguMjE2v8/eboDJY0DWMTkAeEa4
	1lpq7uvpKkeSsAdYvteHjn2iPx1+3ymla+zr3WdBhpw542hPHU0ODDG0WoinHRZJBU2c7SoHMSm
	+YyWPtTg6e31i0ZaeKG18sKjwYRqM+69lPo0Ye4yESc9Wyfx50KZvY4kyWkkXH/tqtsfNfDLDto
	yJsaW59g/gF7VxWhhA==
X-Google-Smtp-Source: AGHT+IFPhh9/9d3Z1KExGsC5qR1rQ2Nm45Wjmm7VVABR3qn4IwSK1xAdFqwX6aTWdeHPxrH9yQER1j4Dx1YablgrOh8=
X-Received: by 2002:a05:6512:128a:b0:594:4fee:c1db with SMTP id
 2adb3069b0e04-5945f1db997mr1889652e87.43.1762768812265; Mon, 10 Nov 2025
 02:00:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105150336.244079-1-marco.crivellari@suse.com> <yq1zf8wigcl.fsf@ca-mkp.ca.oracle.com>
In-Reply-To: <yq1zf8wigcl.fsf@ca-mkp.ca.oracle.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Mon, 10 Nov 2025 11:00:01 +0100
X-Gm-Features: AWmQ_bmvKQL49SwnIgkZ_XaHesOHafDeJPxGggUELlJwkTEaqkOPLpOq1fkn2Io
Message-ID: <CAAofZF5pwbtvfCqdXibRyDJirnrzLRzoCr9dgJ=N1w-NFJkv_Q@mail.gmail.com>
Subject: Re: [PATCH] scsi: fcoe: add WQ_PERCPU to alloc_workqueue users
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, 
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 8, 2025 at 6:29=E2=80=AFPM Martin K. Petersen
<martin.petersen@oracle.com> wrote:
> > Currently if a user enqueue a work item using schedule_delayed_work()
> > the used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
> > WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies
> > to schedule_work() that is using system_wq and queue_work(), that
> > makes use again of WORK_CPU_UNBOUND.
>
> Applied to 6.19/scsi-staging, thanks!
>

Many thanks, Martin!


--=20

Marco Crivellari

L3 Support Engineer, Technology & Product

