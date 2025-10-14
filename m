Return-Path: <linux-kernel+bounces-852022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7DABD7F83
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75F6F3AE751
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 07:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8182C3274;
	Tue, 14 Oct 2025 07:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DyIZGQ3B"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFA12D12E7
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 07:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760427394; cv=none; b=Wf6jmXI+UmdeD7A0xKzsS7m8XxnBEqCRYcXHLT9rRMJeinbNgmtYW2v2dra441r2e5x+23GLS/0Tqf3dglXZby5TZaifyOuilNddQ8VrbN/vd3DTHo1evyuR1cIM7cedVKIQK192Aw/WPyLP+ax6NtRr5mo4pkNeONxrlWK4SdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760427394; c=relaxed/simple;
	bh=L1dhanDEfnANs9rAUgFl6wjAaNE0DKoPAlHcF4Xsjdg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bAgYlale65KNuq7+aZxdnpJjwzuoggxtSQAwWVPsl/x0PFa9Ngn8JVGOShDpezqwoaSm+C2U+qfdkTLrvI49S72b0BlucFlIkJRl4iFrxpftg+RRDaUq3kbCpY4biot15ExtT+GOf+ny20CWOj7l7V8cIdjAoVUi0KWId9SQx6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DyIZGQ3B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760427391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1vjIWoi/164XsR7x2ZrPuJ9XjGOCw1cRW5cuBw3diZE=;
	b=DyIZGQ3BaciLf4qde9B+41Us1tMbmliByoNhNXKYgYzzqwe8Qr9fY4oMI3o32nglDftm27
	49NvkYCYZIqcse8IzNoQG2VOGRTxgeAQi2tcE36ZJcj+9HWTlA6Gw54pIMZu4AKjDxcHOH
	rJ20qccjt4R7irUWWNM52ezMv8OBzwQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-weWym5rDNACU5_3WAa5V4Q-1; Tue, 14 Oct 2025 03:36:30 -0400
X-MC-Unique: weWym5rDNACU5_3WAa5V4Q-1
X-Mimecast-MFC-AGG-ID: weWym5rDNACU5_3WAa5V4Q_1760427389
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3efa77de998so4810336f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 00:36:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760427389; x=1761032189;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1vjIWoi/164XsR7x2ZrPuJ9XjGOCw1cRW5cuBw3diZE=;
        b=PRWH645jbLLkX2B+YQO1oKeV+gu/QJLefqzClosVcuI253rBbT5hdjVM47pJ2ruYR+
         xqF1uivgKQAD0VETrNAYSzJBc2lVOxr02cXU8Oc43I9AVOrz+I9gCto3PqcvNl8MLVER
         lK1K0+vuZ9dD3Ha714nwQdjiazK3TixvK4zxiINRnLx4/XoKeSGB/9GJHAVf6T9/IUfR
         4Zer+Cwyc4Xl/3bElQOrGSWik8hku6Qs39LCg1k/RNWbGgnjn61cvO+X/r1mzKDmRewq
         U/HS0Zy89by1e9LefH2udKe4AURRusFy5qy+dGhhuhymjT7vYBnXkKt8+WNT0XXXUCBO
         LPZg==
X-Forwarded-Encrypted: i=1; AJvYcCVX+wOGM8fonCH5Kh9VtJo68hs5IvmkrwSkwi32luE+8BaAICfmn8G/5nLeeYhAF5FQ/riST40DNU4Wny0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yytc+yvmO3py/VR4mZB+hULAGjhtmuWlZDFsWvLmAhLhMldZTKO
	zdRrBnHXc1AeawcUs5a1fsgK0m/tU/KtwLIQJC26i4UvnYtCRQLcm0T8+i88m57QPGmZWu8Okqp
	rnoiDkDXqpTTAmrveSxGrTHK9+IQ8MG5mjG2N4jOQnSMmH770dYvU338jMq/vrawGwQ==
X-Gm-Gg: ASbGncvbnVR3Fw7hY5bWtFWTmhOcOUrTkJIRcoGPV0AR2u/TDfzGwCDydN1uKbReYBI
	nze+Nlj37QDC9aiGkxyqrie3oJhkYACB2Pa7w6/RXa/o6DwksGV0UIMlBxleZRKGjE23f2eVYLf
	dw65Wy4GVurwwQW74x45nziuwZLvxU7L+xeTZ1UKDRVS9g/SuWT+EuCzDSCw1oM3kxSQHvkZqCe
	AEA9UAYLP9O/TYrah0drEtrG5zCPxdeczzAMeqx6IruWE7SYKYcHSZ+h6mXFWzxcIWBkuAagBkM
	A6lyBdFLk2RdveIVjhn03cynXv0vNzTG27b9ukAMGIf6ShyI7idJcFhuxnBYop+jUepSnkJVt8L
	M0jP0fuIgqOroWrPfUNme8j4=
X-Received: by 2002:a05:6000:18a6:b0:425:8538:d3f6 with SMTP id ffacd0b85a97d-42667177dfcmr14861348f8f.19.1760427388932;
        Tue, 14 Oct 2025 00:36:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgR6EeBgIxPIYN/rDHcLYirWOSSsnc3zChf7HMTDBNzJiYe4qrbYdh+J6TafB+G4Nqz7GOTA==
X-Received: by 2002:a05:6000:18a6:b0:425:8538:d3f6 with SMTP id ffacd0b85a97d-42667177dfcmr14861334f8f.19.1760427388571;
        Tue, 14 Oct 2025 00:36:28 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5cfe74sm21846822f8f.35.2025.10.14.00.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 00:36:28 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Jocelyn Falempe <jfalempe@redhat.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jocelyn Falempe <jfalempe@redhat.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 5/6] drm/panic: Fix divide by 0 if the screen width <
 font width
In-Reply-To: <20251009122955.562888-6-jfalempe@redhat.com>
References: <20251009122955.562888-1-jfalempe@redhat.com>
 <20251009122955.562888-6-jfalempe@redhat.com>
Date: Tue, 14 Oct 2025 09:36:27 +0200
Message-ID: <877bwyq6is.fsf@ocarina.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jocelyn Falempe <jfalempe@redhat.com> writes:

> In the unlikely case that the screen is tiny, and smaller than the
> font width, it leads to a divide by 0:
>
> draw_line_with_wrap()
> chars_per_row = sb->width / font->width = 0
> line_wrap.len = line->len % chars_per_row;
>
> This will trigger a divide by 0
>
> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


