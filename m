Return-Path: <linux-kernel+bounces-820345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E00B7C4AB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 13:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9343246483F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 09:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C35C315D21;
	Wed, 17 Sep 2025 09:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S1jYqNeV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB232EB5CF
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 09:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758101379; cv=none; b=o4pTXTzxqRNFgU37yIO2Fpc9WgrAnSL5J28O+iBSgPirrTNGqU2BBEMDWY9xvLdnCza56vZ85zZoJEEgbIgF+W2C9v3/i7F2rrLSyO6WZrSaIKAj0yO1yjQNtyauqaCCGbcGBZsOGiMnact0adjMabT46hxcY89gIe/+pWGeyL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758101379; c=relaxed/simple;
	bh=sboGMd08IzRCl7r9u0z6Byya/w0YpD1+jtHOHpminYs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Txtmn3qjSe4S+wX/ga1Zlx3lls4Ij59BGrqJEWbrj3jlXhjLK1RQQ5wTAlNBvm+WViORZx4FoQE/7Nx6j0l03Jzzf08u+j11t1PIIisncJCMqOCTsMoIuUOqcmGuFkv+GVr3sb0VoBuGUowxpIijC7p6kmCsPRAzLBvH7768VkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S1jYqNeV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758101376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wUCQQh9tAI7veHkmZZwIWhc25ylIY77meKu24AmxPCE=;
	b=S1jYqNeVnnyvk1amtOeuVS8wLWwwzZBhpQfliIeylP6CXdTXyKCO/0ynKtaOM97hwII+Nm
	0UMX9YTFyHkxjRlQkw9Ql/XvThPeqLyo5OFbCG7KAI66M2UdiFxHRWjeShHh0liG2nlwZx
	PqdKxz5LlxiYMpwuRwKc3dlI/2wJQJ8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-X5HtSRVLPXOMG-u_0Kr0cA-1; Wed, 17 Sep 2025 05:29:29 -0400
X-MC-Unique: X5HtSRVLPXOMG-u_0Kr0cA-1
X-Mimecast-MFC-AGG-ID: X5HtSRVLPXOMG-u_0Kr0cA_1758101368
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3eb8215978aso2344092f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 02:29:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758101367; x=1758706167;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wUCQQh9tAI7veHkmZZwIWhc25ylIY77meKu24AmxPCE=;
        b=LtbNdChXGYx74uQssmo0CTfDOBJiy9r9ahNTmypRgMiY0x3K5rJ/DwU+AxC5BypeuH
         6HjJyts7aFAb/wmdVEdMUG/6Ro9s9tBxNTS8lJ8jjn6exF2FosoldzTvwrsztPcGo0qW
         BK2R0oqqZx4FUWV1SSSyRbRR6foBfjuM/qWWHWDOefvsGsJNPB7E84p+xCdoPgAKj57B
         2z82OQPNfANTcUPwmTMVfgQL9wUmaPdK1IgmVobgrJmikGO+/OWjZCTk43DHHEebU1jv
         CjM3n7/q2EcAqOybSKwxAqVyKZyD3K5lo9/vwbV6lcKEXj6GguU4Gf+rKHat3D51SrAA
         hklQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFSBZvPwAu3Ocxyzy7CP2+DP3aTCnvVZB4ASj62op2E+Rg1E8kEkW+XDaqCgiV96JQ+jckPs5qRqiK0LQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjeP0LhcNST3Ti6X/Os1Ty1hJD1PrU8AHYgiTl0jkwQ28nfZUt
	zKNP9ObIrcWVR/b+MxM1V46uubWObIq/KxK+PzV7cC5CteYoh7Z6JgN3n9ecjj+3RcZ5y/1yORC
	VEyUFkF+UnuyzCmTC/f+09HFdKM9TVbWcrl9p4Ibf6EGSHlCIgiMKrf73jgh6FOy7nlkgxWQnfQ
	==
X-Gm-Gg: ASbGncuvObWJd5C8Ut4jbriWvqmO10zwLmHkTVwdm56aLjbs1iqX6fKV5CDg1kTAkqN
	2csCNHu7CVT/pxBRMNJNR2hl3b4IGlnNiQ/NAiWlSiWfObITiXQH9aXykVTUR9+vOWeYSJF50l2
	OAb6qYBXFlGJdhgi32o8TAB87CviH1h1i4gIO3ZbbCWafMhTVNQPR/pF/aDSW2t0SKzjR7hpdyR
	K/mUHXrDI/uWw9Qup5qTDkySs3+FeVNcGHFS2zKy0+TLy9UAdwzw3VSvbbWDph92gz3m7b53d3k
	PFPtIZfx3uclcKU5o93Z2R8drYHHL+IfZjEeVi6+zylrvZHsdfDbkgxXJQ2PiyWVvYuK2JEQcij
	yTcTRtQYnPmG1FAO1kJDuQw==
X-Received: by 2002:a05:6000:430d:b0:3ea:a694:ae0a with SMTP id ffacd0b85a97d-3ecdfa35690mr1305449f8f.48.1758101367521;
        Wed, 17 Sep 2025 02:29:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4KsQawv6C8tByCVB5Qu4XPEJMv4xk5AwyBCj983j8rLta7/SmmmJaKO4O6wv4Xsl0zvN2vg==
X-Received: by 2002:a05:6000:430d:b0:3ea:a694:ae0a with SMTP id ffacd0b85a97d-3ecdfa35690mr1305431f8f.48.1758101367144;
        Wed, 17 Sep 2025 02:29:27 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e9cf04db65sm13958784f8f.3.2025.09.17.02.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 02:29:26 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Iker Pedrosa <ikerpedrosam@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Iker
 Pedrosa <ikerpedrosam@gmail.com>
Subject: Re: [PATCH 5/5] drm/solomon: Enforce one assignment per line
In-Reply-To: <20250912-improve-ssd130x-v1-5-bc9389ed299e@gmail.com>
References: <20250912-improve-ssd130x-v1-0-bc9389ed299e@gmail.com>
 <20250912-improve-ssd130x-v1-5-bc9389ed299e@gmail.com>
Date: Wed, 17 Sep 2025 11:29:25 +0200
Message-ID: <87qzw5o2a2.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Iker Pedrosa <ikerpedrosam@gmail.com> writes:

> The code contains several instances of chained assignments. The Linux
> kernel coding style generally favors clarity and simplicity over terse
> syntax. Refactor the code to use a separate line for each assignment.
>
> Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


