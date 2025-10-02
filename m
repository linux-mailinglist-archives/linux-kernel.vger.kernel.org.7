Return-Path: <linux-kernel+bounces-840022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B2ABB35AB
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 10:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5A001887E8E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 08:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3979C1459FA;
	Thu,  2 Oct 2025 08:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VB2HS0ec"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C32035898
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 08:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759395143; cv=none; b=FTmtpNWKfCu305ToXTjzNUCNpfCV+2IYmYn9qBEa6rEMxJp2wFhqmgd0XY/SRu3z+DqKG+aBTVCSO+YR9lCej6eGVpMCLL1QZB120Bp6AXOoGz6u5GzHjxOmL8hIqzxHCUJ2SVFha7mFUaFcZa5yj/w+MDCoB8KcVrg3MSgApP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759395143; c=relaxed/simple;
	bh=/3CBBohhudqwobpwQbqaecim4CFxAcA3g3wvz0iNtsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HrVFV+6z8t33T5MGzUIAs3eswRQSCcK55zoEw0xU1Fo6uYup1P67YieHwKuX5X1EzolO5pmz6ZLbjLXnmxO359+SYeoftw6fI9vLsYiPWzUTprMUdQV1TBeGlx8icYHVSpU6sOFaBZORU+KSckeygqUmvSr7iesMiNuniHZpvl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VB2HS0ec; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7f04816589bso93647285a.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 01:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759395141; x=1759999941; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LgjCC+E53eFNAF26kVzyJsHWp/hhdY5/q/808WvxLT8=;
        b=VB2HS0ecQdBVqySejgZigILF7O21n4fZIqYLuNcHS2O1qRxIY5mf55/V6wO7HF2/3G
         4rtPp4eDfMkEttZhp6TE6hBK+GcFcm0lDJPmKsZ3khloscU7kIXvPH14GQX9rcwkjkiu
         ZdoO2mRsHLpUAthe86Lg8M4yJASfgQwmJOyeBgbq69QQisB3WRlxNaLumOn2uIR444Vo
         LJCmQtSX2qmlEujh0SSRk25dJ9/D/K3aOpQH40uyF5cUkjxS/jS6/m+dVIsWH6UJyJxe
         DSsyK1/jwkDJNTMQfdwzG/MbPYj3KPCfcjbQ5ZpXswdwTYRWbozb6bhnAx0SsXiMaNyt
         Fwdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759395141; x=1759999941;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LgjCC+E53eFNAF26kVzyJsHWp/hhdY5/q/808WvxLT8=;
        b=C3ZPEnX/j1nonQsLV6q9TRZxwJahZYxklNZpq1kJixYOOkjExifNUDyCGt2KK8HcAm
         aZ3bAjNhA+NiFHhBf+0rOru46jFSOnMCvuwAsYrSXMTDfb7f26Nj8yx5fMhGmVUWBPwb
         UviydzFVckIvL/yjTEspbzLwQ1UuqDLiRs6YnoR70B1nkIsLSS3kUQKIzARXxH7w/P24
         kQS3aojnRSgiHZwbMiZgGua8FbcepNmp5xAK1QDxD8sn4bciwZbCX3CRnUkpwO8+lXjq
         j17Fu+/QiF4RX4CqG0IZxJHLwdkN9FcRWgQ5deWVkowV/A7+dVys9waZaHF2fBLWYPS2
         Zj+w==
X-Forwarded-Encrypted: i=1; AJvYcCUQCHQ1lY9tQo7YV++sIqGA6i0W7WP4J4eLZr7BTpRBdnhDqTO81ijNDCPc1ONoJJGRuh7fCRibXc7dNDg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9dzgWJ/cVmFChVhOAr7D3BEmOAuUd8NOVAbxG3wtk2hVQpXAQ
	hGtpsKE80ClLjq7gdG2Vx9RzwdJPn51sxI5PqMtMzfQ0y60FMUWKy/1C
X-Gm-Gg: ASbGncuhdZwuCGTgV90hRBccz8zBak0Op0J9hEt22nF7Dma+41Dg6CpjGTR8RPU5ybw
	+HDnrvJ8LCUywH216GU2p0FvgxcGDw60/cwYgoVQ/U/kbIHlx/RDw+tMhITCOA87clPQWlbM2qc
	XEZs7tNyTTifPn6ctW6iRrlpW/w3eQf2aBvHt8XYLZuL6S6MndJg7NyngpkyuV4Q7nujtw6C3sh
	0PPS4e/EUiUcuFw30A0FR1ZWD2/8uZqovHMHCpRB+rdgNejqEClIVUAJWJZLk+uxp3qdsvidVI2
	+g8esfn7o4+S4cTg/k5YkVxxqmokQbWQps/stKYnj+MVmOZIymgkdoi4EYMzPhmf61o8uZ7s9HI
	KDR56YtHXAKH7wkl0D4ftODep/RBcm+6r5pt2UjOea5aQc+sNsYlc
X-Google-Smtp-Source: AGHT+IGU7k3Fz4qxQt++XAUKwlyZTB7u2GlUklYCxfSZL0C3TLIQlcsJhzUzzlXGLVOPwzgjISzYGQ==
X-Received: by 2002:a05:620a:454b:b0:7e8:46ff:baac with SMTP id af79cd13be357-873705ee565mr853440685a.1.1759395140765;
        Thu, 02 Oct 2025 01:52:20 -0700 (PDT)
Received: from arch-box ([2607:fea8:54de:2200::9c5c])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e55a34c6e5sm15894671cf.6.2025.10.02.01.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 01:52:20 -0700 (PDT)
Date: Thu, 2 Oct 2025 04:52:18 -0400
From: Albin Babu Varghese <albinbabuvarghese20@gmail.com>
To: Helge Deller <deller@gmx.de>
Cc: Simona Vetter <simona@ffwll.ch>,
	syzbot+48b0652a95834717f190@syzkaller.appspotmail.com,
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fbdev: Add bounds checking in bit_putcs to fix
 vmalloc-out-of-bounds
Message-ID: <aN49Qt4dezOqAmoo@arch-box>
References: <20250927075010.119671-1-albinbabuvarghese20@gmail.com>
 <cb00a5e2-6e50-4b01-bcd7-33eeae57ed63@gmx.de>
 <aN1ihRfB-GHTEt_4@arch-box>
 <5ab00319-e43e-4000-8814-c7d67f384c53@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5ab00319-e43e-4000-8814-c7d67f384c53@gmx.de>

Hi Helge, I tested your suggestions and they seem to work well.

> Do you know if this affects the selection?
> If so, would modifying (reducing/shortening) the selection maybe fix it?

The syzkaller reproducer uses really weird values where xs > xe and ys > ye
(xs=0xa00, xe=0x101, ys=0xc7e, ye=0x100) and set_selection() already swaps them
if needed and clamps the values.

I added debug prints to check what's happening and the clamping in
set_selection() is working and the values coming through are within bounds. But
the crash still happens when you remap the framebuffer because of a slight
overflow.

I also discovered that when image.width is clipped on the X-axis, the character
count (cnt) must also be updated to match, otherwise bit_putcs_aligned()
	receives mismatched buffer size and character count parameters, causing
	out-of-bounds writes.

So I changed it to something like this:

+	if (image.dx >= info->var.xres)
+		break;
+	if (image.dx + image.width > info->var.xres) {
+		image.width = info->var.xres - image.dx;
+		cnt = image.width / vc->vc_font.width;
+		if (cnt == 0)
+			break;
+		image.width = cnt * vc->vc_font.width;
+	}

I tested it in syzbot, with the syzkaller reproducer, and also manually in QEMU
and verified that the buffer switches from tty1 to tty2 work correctly.

I couldn’t find a dedicated fbdev/fbcon test suite. Beyond kselftests, do you
recommend anything specific before sending v2?

Thanks,
Albin

