Return-Path: <linux-kernel+bounces-890793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B341AC40FA2
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 18:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA8F14232C2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 17:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2270326D4F;
	Fri,  7 Nov 2025 17:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FRuiTEgg"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310AA2DF148
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 17:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762535062; cv=none; b=ud2DxBu0CJllio29wN23lXTyI11AIebQT+Gk4kSh6EoqoBPjqYZ495sL7noNHSHtS/X5n3WazsNaDZcwePwZoj8Oe57YjPcHDRFcglWIkM/EBKDRfTZGa0OLUC8ivxzZmO60dcoOhYEFsXedR8gZeHZhwLJNTUxtLJ2se1T+9iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762535062; c=relaxed/simple;
	bh=jAXZwY1JFAlSau7Sh36qtfmk425lQGaaTTdIu/DKZnA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qm/5NrE+Nen1eHlzZ+1D3PI1+UVrWPwJGiM1SAwmHIyryzUF67SCPq+yncDlhUW04Pj57A6AVVONgUIjLKPCMqLakAYI8Lfy5fz/z/+pA33ZRpSEgDjg8PNozT++kj4NHCjmssY06QU3H1EuuhJWubvwHp/02kx9CZm7cQCeHXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FRuiTEgg; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-592ff1d80feso1133726e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 09:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762535057; x=1763139857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jAXZwY1JFAlSau7Sh36qtfmk425lQGaaTTdIu/DKZnA=;
        b=FRuiTEggRGAS7Vfo1Uagld0Lf18jRFnzxorwEG4ByBp6/oEbLGLvr35XYZm49IZt2v
         O2aqnvp0W+uFG8/pyOSl8K31LpKFMOgvGw+YQpYgwM/iwiuXQiOcqbPVxV+IsOltV+jf
         Nsn5u3IAKa2qCGCwh+/a1oKYKYY7s7A5aQGwCSkdQaQVPX52nQ4AGN7ROYY4l40uu0iI
         eSfmAJq8W93JiOLnxDBTobKE4tF/E7UKkbJS7Vyw+m5JskPebMWujC1Qj6aMUWUhlUR0
         2Y5VJZeu7Bh+uXBgl3TvtCSc3gkQx9cxojtd03G+O0xYt7wX/dIEas6mBjqDUC1WzYXI
         eueA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762535057; x=1763139857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jAXZwY1JFAlSau7Sh36qtfmk425lQGaaTTdIu/DKZnA=;
        b=mFabKT71ugju/tI+WC7eigobi4TVQbouN07KrbfPgyA4spc9BP6fIJi4RoK8yjGOes
         CkXxipyMEfMuCrCg06SvUohuFFfcrdre3nbCayri/ocYACWJ5x7MSzzahMZRQR4R+CBl
         Vd6wQfGfWWFHGc7M4WBWNmD1FlT4WtFkpD1gl82OaN6nOlgnooQsJ5CXNoeg+cdrRcvx
         tLzaep6snfAKR6j8Uno+NakkaBIFsXjsebTrN1YXp3bG07uar7nXOlILKT+Njk+thxkY
         BhZDRWxyxlDZxA1fq7SvkM+hpoCfEHeWXQmLiXw+bd/m9UPFrufVfYx3Br5j7jGcc4jm
         7uPA==
X-Gm-Message-State: AOJu0Yzya2jF0ievDJUel0p9sQncqpnO9PyaAU8a0OsTWmqvNFGycuLy
	K++b4DxDinxXHW6BzJbXSZ6qP1+wxoQnrK3UVEucy7dQYz0OTGPkoc74rSS1VV/TfRbU444HHaj
	phl0SfFcAk662K5Qs0rNcSotlQu2CryKz8E8DVWg9gw==
X-Gm-Gg: ASbGncuOyGQnjU7Mu20EwrdrCn5kUGJp975qwqpozpE3DATm3XnPE/ryXUAAuh1DFGg
	gnUAVLE9JRkKkcgvwZwn6SlfTy5l2ZQA0Sbri39sPNvjyvHs9K/QX0J//kXupkae4rDzULJnh3W
	5rWvET14krAbspZ8MZi1de54DKvDLoi0gNtQX0HWwVnAiYc0MwFXhjY+ExpU7GXKSEr020bV/yM
	0LQOpFHUHAk6TtyUI65laIwaUIzwD8kTtc2VFzmtrpFAAK14+wrVzNOH16Ua3VYV5sswdmtrKqv
	n5VOPtUTBMFeQefzEw==
X-Google-Smtp-Source: AGHT+IEYqlVxvx1AEblNqiEQwOeS/KsDd3n8m7JMMGSQrBI5xG6zdz7o0UWJc+8B7rV9L/oXAJXTHffVLD7ZrMBGPJ4=
X-Received: by 2002:a05:6512:3a86:b0:594:2c1f:75cf with SMTP id
 2adb3069b0e04-59456cadbffmr1263195e87.57.1762535057489; Fri, 07 Nov 2025
 09:04:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107132443.180151-1-marco.crivellari@suse.com> <50rq8s8q-q098-rrs5-r1rp-p5p5r7929psq@xreary.bet>
In-Reply-To: <50rq8s8q-q098-rrs5-r1rp-p5p5r7929psq@xreary.bet>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Fri, 7 Nov 2025 18:04:06 +0100
X-Gm-Features: AWmQ_bl64GFB67e5z_8H7PGOfSgSCx7BB9bx-w6X3bq96IM3M1Sp-Wq2cLF8vi8
Message-ID: <CAAofZF6OBZsD+3PA98dwWEAMmEhOzBTjisHt6daaW_hik2L60Q@mail.gmail.com>
Subject: Re: [PATCH] HID: nintendo: add WQ_PERCPU to alloc_workqueue users
To: Jiri Kosina <jikos@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, "Daniel J . Ogorchock" <djogorchock@gmail.com>, 
	Benjamin Tissoires <bentiss@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 6:03=E2=80=AFPM Jiri Kosina <jikos@kernel.org> wrote=
:
>[...]
> Applied to hid.git#for-6.19/nintendo, thanks Marco.

Many thanks, Jiri!


--=20

Marco Crivellari

L3 Support Engineer, Technology & Product

