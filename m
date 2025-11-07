Return-Path: <linux-kernel+bounces-890764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC54C40DFC
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 17:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AE56D4F4F02
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 16:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9B3276020;
	Fri,  7 Nov 2025 16:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RoWUvi5t"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC251272805
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 16:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762532674; cv=none; b=LJx/59Yp/0DfLfvOVkzgGAkz18l4Jn3X17lnwhIwglE7ipC2UtfwgiNGcqbdSZVJoi8Ty5JkahquYCXxtq0MOi6Koz6QpQnkQfQKh8xrDt2QMNSpNCNMpyS9gs9/aY5GiaGTPWFogobX0JW24uedYRCoocw+4q0Gz6T3Q5N4gpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762532674; c=relaxed/simple;
	bh=Y03UhLZaCnCjcJ7WP8An0sGjRjCfU0LH+nO/nDS9o1o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CVErUxjiLHPO/RCP04DzIzfOAeS+RX9jNiwqrPUouaQoerQ/+grfqGv3FI2oPie63MyOXo0b5CJPyzot4hsQPhwJ8x/HrN99FB8XXDjpTvkcpP/Q1victYBZMkZt9y9oT5h8Rsh9W7xW04yMeMpf1PehL2cOq9CRQXl1aYwccF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RoWUvi5t; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4ed861eb98cso10900091cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 08:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762532672; x=1763137472; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Dg933HfjmwHj361hda6LQqGZtOS/62lJRP7depBzGUE=;
        b=RoWUvi5tCQFpb3VhMuGblvT9VWYPFD+V+WvI8EtJ9zvm8OG744zmu66hIGJXeZ5EQD
         OWxWTTwPgGyTRlxleeSvhQSzRg8CUCjtXT2hpCSdzthAxHrnOeAIFlolDBYS3ZyH2Sgu
         MQJHdZYK6se1nd+giXLfZz0QTF+z/qBZmKQWEBjg154bi1rrfKu0j3nDQYDUI3QIgYLp
         bJ2g1eA60iR/azO1pWZ8LpP7I2xEUShufhMJra7QbFgTbdO3tXeEno/8Olryf4TXyFjt
         kbs6OV/YG8L5T4FOk0YH7nNOcVaNasx/mmb75XZTHCWwYvC5VXt3h+NUCP29z10cHZMj
         ghIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762532672; x=1763137472;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dg933HfjmwHj361hda6LQqGZtOS/62lJRP7depBzGUE=;
        b=HNFDMMr8vIiQqKNBqW7IjL73+31gs7It0PFwivTT2I+CbcHoxnWxM5FlhnP/Q1dj4R
         XOFulwPta1X8569V6frqK5Znoyvi0retqiWVkR4P/ywnPaANqwDhtl0QmhcRrPspHNy3
         cscmc0QUdO3AOINTPvTzarvBkQ53cOuEcHGZIO4BxD4lCr7lOEt+WYipf14agDqP15k4
         A5t3btSawACMsxD4rvYsOgl6kg+PxrXtNMFZvnIkNW8KlCLJooXy5VNlJzhM84oc7mPe
         kzBMapilH5L5hVS843sydMbaWHU6D8e3XihiG91LAWy6rm2faCxVg+Bk6H1aakdtNQbe
         3eFw==
X-Forwarded-Encrypted: i=1; AJvYcCVerlBQzdHw5ygxpLyB3ecZUJB8smYqt4HYpMI+/4Lo86hWTW//DWfXdus+o7YcnUGpo5L0iabvyr/2z/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhgNoKUxblbiGToXm8bkl01lK0PwGGGT3HDpdI1K1ht8bslt37
	FG/10F4X7SzX5+8y6C+CANAFORvwxeU9bconmwjkrLPlUSeWdTgwGIwnSXZImbrByu8u9MTpkqy
	dMVfDIPLuAaXz7TgZ4rEAHF3sLpinCTS05wO2crworQ==
X-Gm-Gg: ASbGncuOmaycFgB45wfDJ1uysv3mgAnzomhVF0PYmapttsx+hczPljrKqRnjD2xq9gO
	9eILWw+El1tPm/xhYXJeSdsnqztIcCa4dfg0GZ91GlUnAMxAq/3g5+FqXOXdfnYn5go/j9U6esR
	hUGTbY1rL1wokahrHTaNg1fIndvpQ1j37L72FBi94Xb4H3rv5kiul3dc+55AQ3vRLMTc3EYbTY2
	V9RVE+j7strNGJB0dFBdA2rXwKTgIfoAnXcPp+zuVdEPvKgxXyZO9gQoNMRYI68YoRAZCOL8lBw
	ezxOYkP4K3+TMdQg7w==
X-Google-Smtp-Source: AGHT+IHCkiDrjY2sdtFhfnWtIG5/yIGmjgCTWa+pkSAhfbWzXXqFVFpKvKWb21AxAOgEsY/fAjUmNILp7tvkwx81+WA=
X-Received: by 2002:ac8:5d47:0:b0:4ec:ed61:997c with SMTP id
 d75a77b69052e-4ed94988581mr46526991cf.30.1762532671602; Fri, 07 Nov 2025
 08:24:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021-fix_etr_issue-v3-1-99a2d066fee2@oss.qualcomm.com>
 <176235893222.387743.2128022832743502879.b4-ty@arm.com> <CAJ9a7Vji3fFnc-XPhdTxh00QW+AjqLqJo=zt+SMwovttQRwR8Q@mail.gmail.com>
 <2835dd93-c945-4c19-9d10-0271b14147b2@arm.com>
In-Reply-To: <2835dd93-c945-4c19-9d10-0271b14147b2@arm.com>
From: Mike Leach <mike.leach@linaro.org>
Date: Fri, 7 Nov 2025 16:24:19 +0000
X-Gm-Features: AWmQ_bnU-O7JUHwcgVFk_3qB9Yn3r0GZGnNdkrfA5bMc_HIfGoFxxRf1tq0dPXQ
Message-ID: <CAJ9a7VgXEQQmj6o7n-mPx0qtrCQXKmddGS6BugHb=xaxVAUTUQ@mail.gmail.com>
Subject: Re: [PATCH v3] coresight: ETR: Fix ETR buffer use-after-free issue
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: James Clark <james.clark@linaro.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Linu Cherian <lcherian@marvell.com>, 
	Xiaoqi Zhuang <xiaoqi.zhuang@oss.qualcomm.com>, coresight@lists.linaro.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Suzuki,

On Fri, 7 Nov 2025 at 13:28, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> Hi Mike
>
> On 06/11/2025 14:14, Mike Leach wrote:
> > Hi,
> >
> > Is this fixing the correct problem? If we prevent the buffer size from
> > being changed while the sink is active - which is probably what we
> > should do anyway as no real good can come from allowing this - then
> > the problem disappears.
>
> Good point. But this is completely fine for a running "sysfs" session,
> as the values are not updated (unlike perf, where the session is
> scheduled out and put back in ). So, I don't see why we can't change
> the values while the sink is active ?
>

Why would you want to? There is no reason i can think of, that a user
would need to alter parameters while the sink is running.

If this is a sysfs session and a user changes buffer sizes between
enable commands as per Leo's example sequence - the result is a silent
failure and confusion for the user as the captured buffer size is not
in fact what he just set.

Moreover, the sysfs files (not just the buffer size) write directly
into the internal drvdata structure, some of which are then used to
program the TMC registers  on enable - which is common code between
both sysfs and perf. Thus for perf you have a lovely race condition
and for sysfs you again end up with values that do not apply to the
session just run.

Seems more robust - not just for the sysfs buffer size. - to only
permit changes when halted.

I have sent a follow up patch which should make things clearer.

Regards

Mike


I've sent a follow up patch to address this - and the potential race
condition.
>
> >
> > Changing the buffer size while the sink is active should return -EBUSY;
> >
> > Mike
> >
> > On Wed, 5 Nov 2025 at 16:13, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
> >>
> >>
> >> On Tue, 21 Oct 2025 16:45:25 +0800, Xiaoqi Zhuang wrote:
> >>> When ETR is enabled as CS_MODE_SYSFS, if the buffer size is changed
> >>> and enabled again, currently sysfs_buf will point to the newly
> >>> allocated memory(buf_new) and free the old memory(buf_old). But the
> >>> etr_buf that is being used by the ETR remains pointed to buf_old, not
> >>> updated to buf_new. In this case, it will result in a memory
> >>> use-after-free issue.
> >>>
> >>> [...]
> >>
> >> Applied, thanks!
> >>
> >> [1/1] coresight: ETR: Fix ETR buffer use-after-free issue
> >>        https://git.kernel.org/coresight/c/35501ac3c7d4
> >>
> >> Best regards,
> >> --
> >> Suzuki K Poulose <suzuki.poulose@arm.com>
> >
> >
> >
>


-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK

