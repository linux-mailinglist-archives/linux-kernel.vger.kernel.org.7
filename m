Return-Path: <linux-kernel+bounces-747505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17306B13498
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 08:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 416051702A9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 06:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD80822068F;
	Mon, 28 Jul 2025 06:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b="GFHIz/dU"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB4A19F40A
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 06:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753682677; cv=none; b=F7OkanXbHnX2aE5xvDEEWRA4u2HJZf9Xh5MyEcIKAyfQMwUwNyms3TY0bk95cvDX4N6wWI7jYbSRBRnNZyP0+1EV6TUyAGkZ94DxKwGOZkc3DO0/k1RPHz+oVmdTVMCiWWZCYgcConRX8GD+EVmG3MO9Aor/Cp8gEmV0LAlLZ64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753682677; c=relaxed/simple;
	bh=O4TM99wkNBJcEvMyA7MFDB4SkOss7XzJLedo0DZAuo0=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=nEj/rTk9Ae7SpawsiMKANFUKNBbq5rEweAu83MqRBirKEiVYXnT1wrxOwPkT9NaJywpS2Z06KGPeSCZy0y9ccXIQ3nmOAF+HKjsXtNKtkyCoSrnwVyEr7/hldXRxtmwezgscOnyrDwvVDlK4Mk5uyJmokqisYTHHi619EjGirLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com; spf=pass smtp.mailfrom=brighamcampbell.com; dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b=GFHIz/dU; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-31efc10bb03so370948a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 23:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1753682675; x=1754287475; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W8TIM/uSluixO4ZsvTxwh9SnRtahNK26geaW1rbU2HU=;
        b=GFHIz/dUcs3IOHbME2YMffsTFHrlqCXksQzoLUe3GZw+WN0K2kMy5tz2FxOuc+t8cI
         aMigFMlDcOHhPYy0OMqFVhCPvlM6JpMIu18MJyjGvFcjKjAYx/tECvVrE7a1mgHuzzht
         JH5S5iu5SrEhv0AXKIO4+4RWxYeHorR/h5P21fwy15YMJR3AYc5eRLMN1Nff//l/gxjB
         bBaVbgtZy0WGVEitIwClZNJjzjDrpTSN4F03XEJIVJhU3L4apuOkIvZEomxWE5WSz2WU
         Sk8pcXcy9Ix524Kq98MzEPlLidtVwvkyAcbxX8L1FnwvuBHu1rgtAn1xMxT6IGCmJwkN
         NXxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753682675; x=1754287475;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=W8TIM/uSluixO4ZsvTxwh9SnRtahNK26geaW1rbU2HU=;
        b=wzgM8Lap/RhX/NL6BXyfmfQUpnbSfTkIBBfxikMKdHjXKWDcf6jYb2xHZlxdimRb65
         hJkmm39/PGZiY+IQE333TfrHJv0eqgzTyE2CzpZpiUJ5MdhokzkIWeMlLNo2LvQz8lUh
         i402uKNK87FyDEqLusyP1KSu+1Kw7duV+xT9HPOSJsB3/JLyYRsRjaPEmKKanxptIyfq
         uT1QJtNlHQK89ay15jXLbi6EBdoK7s1Pp4uqU5BwCJzvDWngfJMAahNo+bLronWXC9MB
         pH+aXX7rP4Br8iO3EqPVaMC/Jc7F4Nc7gnHkoLoMALR0UiFigezJvoZVqow787vZZv4l
         2kDw==
X-Forwarded-Encrypted: i=1; AJvYcCVDLY45LPy2g+Kz2QJEtEJCLiFddbzXiCP0lgqgI9jY+VlTS60zbxiyS1T8ucEYqXM2/0O1qQTcsh13K7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoMP+yGjIMxDWBuqeod2v9xnUKFTW5huTll2Syv4d8evRpxQYm
	YzqKcPmeq1sxlD1O8+ohD2tos8wb79i9n9RKODSAIul7S+XiBT7r9rUfeDXDuDB+bSY=
X-Gm-Gg: ASbGncv4VuvD8a03MJBKnx/CU0FF+/wk2VjlDLqwtztYhusHGQWlaNPTppb1hqEST9r
	mhRqc6/67c/82D/yLsApfc3C2J5wHFppp5JhhQCdysdTg1SqRfYYzgV06rNvEPbvrrFIxJ5ToTO
	CLTeRkg6LRDOLXbqrARmqiikPt/U8cbfJ71IfJyFLt6cjiwHBk4ifHT+T3eT8pUJzjJkoRM6nd8
	B9nyKP0hWdBfWAHNLuMNOlEN0QKjYx8AdWzAreEQnVL6ScgZeHkOvYBnqoBd350ERxp4U6liKP+
	Yzk09XEN3CvtX+NZCAy80gr5xBiQ2MZ/aufJIbPRyrGeDC4NZhButcgwp2ezd0AX97vkpcLaSiv
	gLL93LabR6xE/9JApPAA=
X-Google-Smtp-Source: AGHT+IE7a3uEkAL5faXj3D0sBZPBBYHiZvFmLCc83UwVWA0SEZUuwxE6gkHZtvmEceEe841TShqa0w==
X-Received: by 2002:a17:90b:2d8c:b0:313:b78:dc14 with SMTP id 98e67ed59e1d1-31e77635171mr16398777a91.0.1753682674660;
        Sun, 27 Jul 2025 23:04:34 -0700 (PDT)
Received: from localhost ([64.71.154.6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e83545002sm4811767a91.27.2025.07.27.23.04.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Jul 2025 23:04:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 28 Jul 2025 00:04:32 -0600
Message-Id: <DBNGMHS14LUB.3PDFCB3DI1789@brighamcampbell.com>
To: "Doug Anderson" <dianders@chromium.org>
Cc: <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <linus.walleij@linaro.org>, <neil.armstrong@linaro.org>,
 <jessica.zhang@oss.qualcomm.com>, <sam@ravnborg.org>,
 <skhan@linuxfoundation.org>, <linux-kernel-mentees@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] drm/panel: novatek-nt35560: Fix bug and clean up
From: "Brigham Campbell" <me@brighamcampbell.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250724202338.648499-1-me@brighamcampbell.com>
 <20250724202338.648499-3-me@brighamcampbell.com>
 <CAD=FV=UGNN68Fu4kJQQ8jO+fYP4qVJYmL0quxa_=Y5GEtS-jMQ@mail.gmail.com>
In-Reply-To: <CAD=FV=UGNN68Fu4kJQQ8jO+fYP4qVJYmL0quxa_=Y5GEtS-jMQ@mail.gmail.com>

On Fri Jul 25, 2025 at 3:17 PM MDT, Doug Anderson wrote:
> Hi,
>
> On Thu, Jul 24, 2025 at 1:23=E2=80=AFPM Brigham Campbell <me@brighamcampb=
ell.com> wrote:
>>
>> Fix bug in nt35560_set_brightness() which causes the function to
>> erroneously report an error. mipi_dsi_dcs_write() returns either a
>> negative value when an error occurred or a positive number of bytes
>> written when no error occurred. The buggy code reports and error under
>> either condition.
>
> My personal preference would be to code up the fix itself (without the
> multi transition) as patch #1. That will make everyone's lives easier
> with stable backports. You'll touch the same code twice in your
> series, but it will keep it cleaner...

Oh, this is good to know. It makes sense to me that a lazer-focused bug
fix would be less likely to conflict with other changes in stable
branches and would be easier to resolve in the case of conflict. I'll
just fix the bug in patch 1/3 of v2.

>> The usage of the u8 array, mipi_buf_out, in nt35560_set_brightness() may
>> be a little curious. It's useful here because pwm_ratio and pwm_div
>> aren't constant, therefore we must store them in a buffer at runtime.
>>
>> Using mipi_dsi_dcs_write_{seq,buffer}_multi() in place of
>> mipi_dsi_dcs_write() gives the added benefit that kmalloc() isn't used
>> to write mipi commands.
>
> Ah, this makes sense. We've seen this before, but I keep forgetting
> about it. Thanks for mentioning it. I wonder if it makes sense to have
> variants of mipi_dsi_generic_write_seq_multi() and
> mipi_dsi_dcs_write_seq_multi() that take non-const data. The only
> difference would be that the array they declare on the stack would be
> a "const" array instead of a "static const" array...

Ok, I've thought about this one for a while. The problem with my patch
as it is now is that it uses a u8 array, mipi_buf_out, to construct MIPI
messages and send them out. My patch reuses mipi_buf_out because it
happens to be the right size for both messages which need to be
constructed at runtime. Not a super clean solution, perhaps.

The Novatek NT35950 has a better solution. See the following function
from drivers/gpu/drm/panel/panel-novatek-nt35950.c:107:

static void nt35950_set_cmd2_page(struct mipi_dsi_multi_context *dsi_ctx,
				  struct nt35950 *nt, u8 page)
{
	const u8 mauc_cmd2_page[] =3D { MCS_CMD_MAUCCTR, 0x55, 0xaa, 0x52,
				      0x08, page };

	mipi_dsi_dcs_write_buffer_multi(dsi_ctx, mauc_cmd2_page,
					ARRAY_SIZE(mauc_cmd2_page));
	if (!dsi_ctx->accum_err)
		nt->last_page =3D page;
}

The driver has a couple different functions like this and they're all
for the express purpose of writing out a single MIPI buffer which is
constructed at runtime.

Arguably, a more readable solution would involve the definition of a new
non-static macro like you suggest. The macro's `do {} while 0;` block
would achieve effectively the exact same effect as the functions in the
NT35950 driver, causing the buffer to be popped off the stack as soon as
the code inside the macro completed.

We could call it mipi_dsi_dcs_write_var_seq_multi(), perhaps. Or
mipi_dsi_dcs_write_sequence_of_bytes_determined_at_runtime_multi()? ...
(Help! I genuinely don't know what I would call it...)

Please let me know if you'd prefer that in v2 I adopt the approach that
the NT35950 driver uses or that I instead introduce a new macro for
non-static data.

I'll address the rest of your comments in v2.

Thanks again for another thorough review,
Brigham

