Return-Path: <linux-kernel+bounces-899905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A7AC593AD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 302A14E9CB2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC7A3570B0;
	Thu, 13 Nov 2025 16:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jNK3BhNk"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1790D2EB5B8
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 16:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763052740; cv=none; b=Zc3NYFnPSzMFLUWfukSSY6NZbox6LAf+4qA9kla69VvWDc9NQg5IANVLWJ5Ds6CvtDRoTCaCWi3sGvCwEJX2biOOwwp5S3DV2kEoDB00h+d0CwJdpZIYleI20aEbeF+mQj/DtThmosisTqr4DDt/2HwVBI7MIafDPMO2A4tOjnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763052740; c=relaxed/simple;
	bh=rUsAX1hJeV3UPnWGm/4xcCudOaMjNAHTr++LpRShVBo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G9xxb0nl+R4fQwxbvzPofb09NNvwYkEirfRoHZaZQZhTX3SPrI/asvFygpsWTOk/kbbeamhA8+OiH1peJ30u5nDf9t2bJqqnJDLXVuSLnk5NvKrVA0thTTe4BB1VZP0wRRtqC8MR/d9MgwlO/IwsbbLlxCA4EKlRvTwh7XKpy3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jNK3BhNk; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-88056cab4eeso7974826d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 08:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763052738; x=1763657538; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0mynV+GHs/CrH2G/vi7leUTo77zQD5QcWplvVVXMbv4=;
        b=jNK3BhNkaoMJTEB7UURYRTJ86/gVaAxTOImqC8SUMcsjgQvollDhfReacHHdMfGwA/
         TI+Yw8Pa/s3Ua/i6nHW9fowEF8hnRZB7vi9yGgiMkpwaXg1MIrOYdp75UiigLEBO1DKk
         s2kdfgHsUeVTBo1Ot4cBpuLFIjFOgFOwG/OunfDfMfBR47AgncuiHiCbWLZ6lRpUWZP6
         figMWFuWQV6mZRxjIBXr6y5l6GummY/UBMNDo6ctvL+ylgS3z7PfKh9Of+cKtg+dfi+W
         i2B1AVcftp6WB/WLOcdU6o2gRhwjXXc+MlRl1i5qPmAa1q6B8Pr1OYLPk3yEoGTy4AJf
         gL6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763052738; x=1763657538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0mynV+GHs/CrH2G/vi7leUTo77zQD5QcWplvVVXMbv4=;
        b=LD4ifnH5QU3XpZLTKnnlMq14isTGdydjekp6leW34/Itfj6sIqqOYE/2ascAt+VnIM
         +thAHvjqBclxmX7g46kj3frqpo2FFU3a6O0FJB+O9js2c1zbmMSts5RMQGrbTkvvxCum
         JRnlQgNXGUrx8rNr17XlCIr83eHccNz8Le7ZFEFnpMuFPpETkviXf7fh8kbw4Z+DY8iR
         nAIwiXvFq5N7o20zbl1Yxuhj3ZenTpyBUa1Gw/yFdlUgMPycnDTXCFE7LM2gE8h6nFQw
         j3i4oEVG40w9z+1o4OuLXvq/BDiAJgWWKpdtrEFBw4wgX2xhCUDK/BeLY23IeCfmDYaE
         zIKQ==
X-Gm-Message-State: AOJu0YxFP4l/aQpVEROv6jQrwA7FmasTK/a4nbgWEh8hGSJCsvjvQA8B
	Jh7SVTMO8Tr7PQCLcShnfoGDEOvH0Ypgsj8Zf9p0pIA02pXwPU8FA+tND4aKzrEWNKQlE5oDp8t
	EI+oXNfuJkTK+6Md/bZ5ayj4N7PjfSayhtawNi3VCNA==
X-Gm-Gg: ASbGncusgLCP9tulTg/wr6g7j9wLuByWgeu0FSgDucvvsL8QrHv0LT79AruccyW5r8O
	pLUyxrrPwspyZnKcbBbDrNNLQw1VXyLEt2ZmyBfAoy9rwkgGhAfUMtNQPdMxJl60P7iMKjhyxZm
	UiXDSMjeQP/H7N6YQlgtV1MCJgwTq6ZV06jdIZYtcR1ZEvRyNH+QuoOKQyUSfNMHjqMpfWqdH0E
	Nkd6AC3ouCRM1uyZGo9Qtc8ycd8fI7T0RA6/u3D0Cu2fLc94NYrc8it3B4kq1LK3Wj4F+bfX4xt
	BZbnaBBqephXzjY=
X-Google-Smtp-Source: AGHT+IFAjjUWJoB6+DGMKzPFhKUEj89t2ZHLbzeHKf+SFqB+mY50Gj+u07b773NUKNPje4KAOUrALvfWraGAgQ4ykxA=
X-Received: by 2002:a05:6214:21c9:b0:880:4548:a05f with SMTP id
 6a1803df08f44-882719da939mr114448206d6.37.1763052737756; Thu, 13 Nov 2025
 08:52:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113163426.2950-1-jiangshanlai@gmail.com>
In-Reply-To: <20251113163426.2950-1-jiangshanlai@gmail.com>
From: Lai Jiangshan <jiangshanlai@gmail.com>
Date: Fri, 14 Nov 2025 00:52:06 +0800
X-Gm-Features: AWmQ_bkMXFLhogyswEgFRuEJTM_l4M9jRDZTWH6DZ59s_WRlZmfQt4tJtUL5kmU
Message-ID: <CAJhGHyDEAM4opmhqqkv4Fyqdop3_E0y2hBEdRnCv7xiP6V6Uvg@mail.gmail.com>
Subject: Re: [PATCH] workqueue: Process rescuer work items one-by-one using a
 positional marker
To: linux-kernel@vger.kernel.org
Cc: Lai Jiangshan <jiangshan.ljs@antgroup.com>, ying chen <yc1082463@gmail.com>, 
	Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello

Some extra stuff.

On Fri, Nov 14, 2025 at 12:30=E2=80=AFAM Lai Jiangshan <jiangshanlai@gmail.=
com> wrote:

> @@ -286,6 +286,7 @@ struct pool_workqueue {
>         struct list_head        pending_node;   /* LN: node on wq_node_nr=
_active->pending_pwqs */
>         struct list_head        pwqs_node;      /* WR: node on wq->pwqs *=
/
>         struct list_head        mayday_node;    /* MD: node on wq->mayday=
s */
> +       struct work_struct      mayday_pos_work;/* L: position on pool->w=
orklist */

pwq->mayday_pos_work, pwq->release_work and pwq->rcu can be made to share
the same memory.  It will be done in a later cleanup patch.

> +static void insert_mayday_pos(struct pool_workqueue *pwq, struct work_st=
ruct *next)
> +{
> +       unsigned int work_flags;
> +       unsigned int work_color;
> +
> +       __set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(&pwq->mayday_po=
s_work));
> +
> +       /* The mayday positional work item does not participate in nr_act=
ive. */
> +       work_flags =3D WORK_STRUCT_INACTIVE;
> +       work_color =3D pwq->work_color;

I thought quite a while about the color for INACTIVE, I think the color doe=
sn't
make sense as long as the color is "eligible", so pwq->work_color is used h=
ere
rather than inheriting from an associated one even though I can easily get =
the
associated one for this special positional work item.

And I think struct wq_barrier can also use pwq->work_color, and the common
code in multiple places can be moved into insert_work() which results in
much simpler code.

It will be done in a later cleanup patch.

> +       work_flags |=3D work_color_to_flags(work_color);
> +       pwq->nr_in_flight[work_color]++;
> +       insert_work(pwq, &pwq->mayday_pos_work, &next->entry, work_flags)=
;
> +}
> +

Thanks
Lai

