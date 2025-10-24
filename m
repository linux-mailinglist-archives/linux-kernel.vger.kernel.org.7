Return-Path: <linux-kernel+bounces-868486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FA6C054BE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 11:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 93AD04E5DFD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 09:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929123090E2;
	Fri, 24 Oct 2025 09:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AYobzKrN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672D0207A22
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 09:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761297584; cv=none; b=ckwFAgiwxC2E3ELszI1WLR0Hh+3Ei57ZESQ0znXw/1gjA04dsHlm28n7JfjeyUfBcVqEbnO+EFv5FIfFZ2oIFg7N+Xsu+KauYwu1/VjvdJVCz7t+e5wB41UH7Gj8HlpAgnrK9EqX21L7WsCbkcAFECAaEHpCz+E6V/QZQrMnHIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761297584; c=relaxed/simple;
	bh=j8G9QdbIqwBg2IhRIRuqyIIJgusHkL5GWb5WXWEG8ZU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=engTOX0/tdqgmz1aiPBY0nSqeaSZSMhKnF3arLcwTHifHa0i2Q1i66vPpvTlbtpn/NRh146CqCtudFhA5SL1aFkfhuRKOgIWr/xawQF8kcoAspd+RX3OZwgyVYY/ova07Rf0yVz4bNKgcqATxOcuUoChqR0ScFDuaLyV7a02Ka4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AYobzKrN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761297581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gjlhKf1lSLezGbueO5hgy+8/2iDTdqmHQ6e26A+MZvI=;
	b=AYobzKrN9yVSMU1MoUKeMqkWGLsiaiZF0hYaVjycq8fGQORSDAEGGMio2OXyVlTj2mZeol
	3ewu/TuJb9QFZ3TeHQD2obrt7Fo4vOMXWvmJQHrcFOojusC4oDGdOdF2AOJAL1/Hbsb+hX
	xBS5YZJaykdH39RRwgDdA4H3P1MB1OA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-8HvHUuyGPxaNaSPwhL5gKw-1; Fri, 24 Oct 2025 05:19:39 -0400
X-MC-Unique: 8HvHUuyGPxaNaSPwhL5gKw-1
X-Mimecast-MFC-AGG-ID: 8HvHUuyGPxaNaSPwhL5gKw_1761297579
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-470fd49f185so16137845e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 02:19:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761297578; x=1761902378;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gjlhKf1lSLezGbueO5hgy+8/2iDTdqmHQ6e26A+MZvI=;
        b=rZ8G9tVj6KhQmihV2C2qtLcwIfHtjlIw/ubMz1HZiwvpblagTgiDaU53sYQFNVWLyu
         liLrw1vc2H9cKjssszZOYJIzTP89zJltJjo/S2AemCBV8AyJBxuswxalAZproIjB93nG
         mNnVDancdHX7a3w/rUB6y5z/rxdpIlzT2FYZahjHgg5IZ1YaT1bFPOCJOLgDgXLKnv28
         mKODJPRhmWkLuV546XjBB11+XCgIXPDu3LiE7T2QOmxZxhtlh9CVVmhtp33imX85MPjn
         wqDlvGPwrGx7mmqlks/vODMvmsvCMOu5YqNHGlKlk0XGBAXsPaXAlaZTSXYgVhEc9qwR
         JkKw==
X-Forwarded-Encrypted: i=1; AJvYcCUP/rSNG03SueOh4FMiu3JDq7myIij6eQoZQbxZG1r6pR5U+TtUE5z4N4ckxU+sIwO64VtHhFK0UaxqIyM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9O1EUisV3v2N5xIurHhtDuNEIFIuPUMGDU3G8nihCiZiXfz6z
	gO7zOHeHQkztJPwPPdvH1PfJzmN+0SZC0TFuxFKWlAmFJ8Fm/L8NUIORzCQF9FzcH1axGrwpujQ
	C3XJ/2WIWs8LG5kk39IOdldXBADCuT3DIfAkmvELbTCY9T5hvNRCcUimDCOwUEkr0Ig==
X-Gm-Gg: ASbGncvo/H3GVpMPlxx1tzmyh/ZMfZ13PNCsIC0606pA9Dwd05gGCduMU4Oej/6UQfq
	/HBhPcnlVoqxIDLnXTb6h35HGXyEPhSS3hDGRfaOdMwDwGRErUGc8xOoPM5pAr3n0YD9hWr5+RH
	ODvTjp5JNk46jwrns7S13vsi9h63wYsD9paIvGm+5BmPo+xa/oBfIuILx/Y1eeRumsBM8MEZCfv
	wjmVn+OR+X9IbrzFvSdSDTgbeut1esJ/kpYmgyVGEGk47Oyvp4YaeU+rye0EBklwsE7zxt2+T1M
	u3IxgtM41wz1VXRAkHOMYL8/D0P8gvDq452kje69aZEweYEOTJL7bUR2lJ8qd8CUrA3O+jgJxiQ
	LRKWXbk3mbKw7vny17VphrIMPXXixvopI2HyQXZlWrkHXZ/IvQGVZiRlNlQ==
X-Received: by 2002:a05:600c:820b:b0:471:1717:40a with SMTP id 5b1f17b1804b1-471178a8245mr197432865e9.18.1761297578558;
        Fri, 24 Oct 2025 02:19:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPRojaApcfmKLinZI5+an6nxl1x1LRwFmTf1gBlrYMQPX1+RmkaC4nUCtM8shmyfMR6tCbSQ==
X-Received: by 2002:a05:600c:820b:b0:471:1717:40a with SMTP id 5b1f17b1804b1-471178a8245mr197432615e9.18.1761297578143;
        Fri, 24 Oct 2025 02:19:38 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-474949df22csm84324805e9.0.2025.10.24.02.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 02:19:37 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, ardb@kernel.org, jonathan@marek.ca
Cc: linux-efi@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 1/5] efi: Fix trailing whitespace in header file
In-Reply-To: <20251015160816.525825-2-tzimmermann@suse.de>
References: <20251015160816.525825-1-tzimmermann@suse.de>
 <20251015160816.525825-2-tzimmermann@suse.de>
Date: Fri, 24 Oct 2025 11:19:36 +0200
Message-ID: <87zf9g8xnb.fsf@ocarina.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Resolve an issue with the coding style.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


