Return-Path: <linux-kernel+bounces-894810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 35864C4C23A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 08:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9637034F25A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 07:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6C832C326;
	Tue, 11 Nov 2025 07:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="XcqgXAoX"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CBC2459EA
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 07:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762846811; cv=none; b=AsMUAU4+OGeAS/3GPlbipExZLXVGvEaH1ovTegNmZNCT3V1WINwjKcot70xIlT8NMDBU+cvw9mE9Kyk9DXfGP0o6SblrytSb0GOKrdNN9S8iLtinywVVh1sQPkMUdf/b3qCvRY2v5yEJ0rvEAxrIMd7pEzCddwltro8LHoYTfYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762846811; c=relaxed/simple;
	bh=07cyLv7Wgyzl7kS2WQ6zD112WskJ3xP9TA1hsGx1H+o=;
	h=Mime-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VgCRpN5gLqZNSYXcgjYPQ/CDGQCo7Q7BvWPhDF01DZzmXAxoa7XDHaa9FmZ9o9CX4stuLDdZq6CHdqs0W1qyb5hJ0IvpwKVdmsabcI4AaP8scZxmqrcmqLFVUc+IX7g/UlbxlwhnQGT9/MqO9hVnw6AZoh078GMX5hP2jGN5TL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=XcqgXAoX; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b73161849e1so294579266b.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 23:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1762846807; x=1763451607; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=07cyLv7Wgyzl7kS2WQ6zD112WskJ3xP9TA1hsGx1H+o=;
        b=XcqgXAoXMVc/y+QEKcemDZK1DfxMqbzLy/exHZktIkQPjgLNjoWeVKznAZer8Galz6
         quxVugtahrwTaZHxTJeh8tNmhNxEBve54gAffCBKHfyh4T1hduN29w6DDdX+Vo/aQJ/z
         m4SPAj/QNLXo8APABqwV4Zyk9o8sSqVRdQi5z0zXQKVNDOyRZ+ehq/Su4cVzpNOdJKr6
         4oWaHXwqcU9vRBFrE73yqEcNJ6Pkxas/OsLCGsIhZd9ODQYCRrK/4DQUYuc4PUKWR9xN
         7WyCs69O+rIk0/WdKYdrA5lA93lWH09R568J8mKNz0U3isgRrPaucgk3JCSKOe+vXNQB
         V9kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762846807; x=1763451607;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=07cyLv7Wgyzl7kS2WQ6zD112WskJ3xP9TA1hsGx1H+o=;
        b=JF8jYxMjNdirnHffEVI0ZdCFfehUlJrLp9nbDOEtmgFpFI+eWAYew/5bhPj5CxUC0K
         Fuopanpn1d8QLlPxj4iBQpWhXHHBP6mD3BHD8pxCa5+Hi2Fc8GYDqqANV9XEkUoCpijE
         PAEWwr5YTHLX9wiisUQ56pxQOVpe5nmpmHByfSaSLPuPLf9SlgUhpdItXmYN39sDM074
         ggn/GOvUpbdB/HxNcW+F2wQVmfa20Dewhwo+Onwk6jHwNf0X2Q3spJ1GEaM+5vTqI4Nh
         JtfJhnKiqX+H1+6c5wRi3FTNHsSQ65bNVFtGEJyzHHWYB7/dmFKx8kBrjqh7Lq+GPbSA
         bJVA==
X-Forwarded-Encrypted: i=1; AJvYcCX3SwjksXU3xTTydB8aSlTugQ713bfNwcgTD9h+Zjkt6iMExX6N+0JialVYbdMvOIjbLjYGURCgDDd5+Jw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuHoX7R/cCoenoXNp73uDrtG9H8jGZ6v2b9CGZfVM6Qc0dDbpw
	IzPOfQmiY2X5IP3RluAMcpCci1yKYt5kVhMHB31U1ui7wGkkeYcWWLr2Em8pGej9Sm2iITvDxuD
	xi0i6kctH/gMo+R30Tsupiw3jM5YsricbQSLQRoJx
X-Gm-Gg: ASbGncuNr+ZGTXo8QLIJwE5FL697efc+vIhkLQ+bjH/WgIFGMv7GCx39aFEH6uI368J
	ho0yP9XUghLXEEXeCQtH7fy+5IYLeJmQV03aKSlwRvkGqfuk5KddiC7EiJbgR4/But0CLc9WUcH
	FrTB4Q4+vI3ex9hlUdoIJY3T9YljIBwybtjuEPzpyUhua+S8WH62wfsSIVx0lAYVkh2RwWWOqJo
	UW3vQZjN31TfmaXNoDjgzolMtFtyyyqEBNp9CJAsD+T8qFAqaYOioSzVlLRTKvRVsEMZdFm
X-Google-Smtp-Source: AGHT+IGTCHTGU4IM0UtqU2lEebI6caPJc7xsEDXjwHspBhpVAn2IOCc0tVgOLV9YWiWLv1b6hu1+D1v/DooVaCfv6+8=
X-Received: by 2002:a17:907:3e04:b0:b6d:5df7:3490 with SMTP id
 a640c23a62f3a-b72e02733e3mr1085979666b.1.1762846807505; Mon, 10 Nov 2025
 23:40:07 -0800 (PST)
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Tue, 11 Nov 2025 01:40:07 -0600
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Tue, 11 Nov 2025 01:40:07 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Aaron Lu <ziqianlu@bytedance.com>
In-Reply-To: <20251108073829.7594-1-wanix1988@gmail.com>
References: <20251108073829.7594-1-wanix1988@gmail.com>
From: Aaron Lu <ziqianlu@bytedance.com>
Date: Tue, 11 Nov 2025 01:40:07 -0600
X-Gm-Features: AWmQ_blhY1VpCaanXMeugj6174kZO5T8LxiCy7AZPHv7AAEMoHuc4MexgSYqJ3k
Message-ID: <CANCG0GdjAaXG5U=9etbC3qo5uY7fbpFTG_RqoKcgChVSrLOKWA@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: remove redundant se initialization in unthrottle_cfs_rq
To: Linwei Wang <wanix1988@gmail.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Linwei,

On Sat, Nov 08, 2025 at 03:38:29PM +0800, Linwei Wang wrote:
> In unthrottle_cfs_rq(), the variable 'se' is initialized at
> declaration (line 6024) but then immediately reassigned at line 6039
> after an early return check. This redundant initialization is
> wasteful, especially when the function returns early at line 6037.

This redundant initialization is addressed in commit 956dfda6a708
("sched/fair: Prevent cfs_rq from being unthrottled with zero
runtime_remaining").

Thanks.

