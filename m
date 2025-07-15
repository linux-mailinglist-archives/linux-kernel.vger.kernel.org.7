Return-Path: <linux-kernel+bounces-731127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3020AB04F7E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 05:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59E833AE5A7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 03:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76EA52C17A8;
	Tue, 15 Jul 2025 03:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n3d4cfIx"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F13D22083
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 03:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752551518; cv=none; b=mTwWRJsyRsSVKou7fL/DXkU+9JFRWWMI7Ih8XB2YCInAbpwcoqacstTjfQhKJeKgiBp72GiEIGwA/9aE753yQXei9jncUo3ouQNbu6xM1Tz3+vJWDdTUobg2pMougPWEkJivDHVJ5Zhp9HMOhusr4u6JLbbuiFcV9yGV4JFwL6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752551518; c=relaxed/simple;
	bh=cYSfb64ZGgwqHKwvNtcb1nxFMgVVvfX7QP2RutsAxY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NEdndwxoP9wYlWesdOq+notM15XZxi5e9hcmiGAL3ilcmdXko4wvHHOJXRcDhI8yjER4p0OgogpqjbBYvhFYPQ+2Hn6MLrqvOWMmSTRemvS08qcAE0/NKmT55A2bLa4+R3sJ4F2X1A7/m+CxrjLZsk4evfX5gXMKfYGtECXiEHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n3d4cfIx; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-237f18108d2so106275ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 20:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752551517; x=1753156317; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jsUIwyee+HFqtaAoRVxiMN9bCqd/uyCjpFzT7KZEvWU=;
        b=n3d4cfIxEBzlbdBzjuNeOpX5G6vZUJwSOwvKOw/6B5R1SpbNk8zibtnI0PjfHbv/jR
         09hOSyYZDtkhenHTSA7IrXhLNJn28u42i3fUes1z26yde4+ViCzUhqJVgRXXLWU86q7I
         qf5A9F3rQwhyeKqhq4G6GzAobNC2NFKWjKMUREYrpf93loK7wocTJkdSprN1RWrdRBHW
         lrobkxPpI/YznsK9e5Jma4uUlgk6zuGAYbW+MH29YW42cweOELmINoy6YKW33VSC+f50
         lgogjifRNVpG/QBT+G67U4w6mJju8R1C8jGd2YN5JLHlmpdiqvWzeZm4P8pV84yxuOSY
         gm+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752551517; x=1753156317;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jsUIwyee+HFqtaAoRVxiMN9bCqd/uyCjpFzT7KZEvWU=;
        b=Ywauhhx8aE4EPLCoeZ+7l8aZiBi9hNiha/TOsKQOODOGvpyeXteFh9NaPhyghZyzXc
         YtXc39ED4nGzA+/xZVXyjl6Iwa5cBEqfCvXThqfYoTxcPPwijOzgMCgLrs89RAZRwZLe
         HMHXRg/KjqpcTDKUjgyxsP72ZsH5meNkn5pABifXxm1TAbe1uNBVvnx4V0TmPrcjTlHG
         nuKqqtl+ZVsyMfa70AcFMzF+l6L1fF8LlkTasI7Cel329bZssx8dvi5SlzJMvcVlOg8G
         ppZmnlEgr09deGw4sJ4MBPx/XEnUP9skIBodd7s60DyEJiBsGcUG58qW10558msGDCE6
         7TDA==
X-Forwarded-Encrypted: i=1; AJvYcCVhTO3BHRzuT8skDCCz5laMX5hQ7Jsd8bsqj4MM1f7zLp22rgpsPdTIlTuzltbBI/lOIqI4Rde7EpdZSFo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPpWot/UIMa+jAfxnpfrNUE3pvUDzd2+57+VYVuBbznKDAy/wn
	yASBnoEXNaYX079OeV+TX0uNJIlr0da+VD6IMDhzjZXgBXC8xadxE1b6OyPYbUI8Pg==
X-Gm-Gg: ASbGncsPKydmid9P2mhUG8xEJyzqYI2kf3t+aLoWiYvZcA0IouTLCju/w6Ldi4TZjD4
	YtcPiZ/BnJCnhxGsH9Y+0FTs4NlqgrUc0CANNWf24YKXHxqLoGxrxSK2o4jbC2EIWDcK5opy/fv
	GAwD5D+Kiui6nwerIVvO8SiVD94D6qXi1/Y/MbDBV7dYVYwrm6r8csptroNv3zA1LYYdScnDr16
	1zN0btU4JvCi5qwfVJYmiEREcmyKhH6+LUNq/L9xkFvqmbGsWT6F+avO93+h17jv+AjejjxuQQo
	TmMK5Qok+0xLJ4cqqL5nuv3+1MdCEfjldugYa4rTIn3g3c5Cxtq3/eEbHL7EvlbhCq2vzXH2zD3
	LgODkvkHN/nmtd4cCPWVAwoPPqYJ2it5JbFCTQKGaegwXPvC2MSxDM05R1WiWHpw=
X-Google-Smtp-Source: AGHT+IHTysO/Y1sEuDEGTKG0EXrcpADxjuyygledERL26mdIyqvOokaQ3TnLDkC9IyRJTWuSrpB04A==
X-Received: by 2002:a17:903:910:b0:215:42a3:e844 with SMTP id d9443c01a7336-23e1b548ed1mr808995ad.17.1752551516500;
        Mon, 14 Jul 2025 20:51:56 -0700 (PDT)
Received: from google.com (135.228.125.34.bc.googleusercontent.com. [34.125.228.135])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3bbe6c5f29sm10954493a12.46.2025.07.14.20.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 20:51:55 -0700 (PDT)
Date: Tue, 15 Jul 2025 03:51:51 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	"Tiffany Y . Yang" <ynaffit@google.com>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/2] binder: use guards for plain mutex- and
 spinlock-protected sections
Message-ID: <aHXQVzw5OFENVRR1@google.com>
References: <20250626073054.7706-1-dmantipov@yandex.ru>
 <20250626073054.7706-2-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250626073054.7706-2-dmantipov@yandex.ru>

On Thu, Jun 26, 2025 at 10:30:54AM +0300, Dmitry Antipov wrote:
> Use 'guard(mutex)' and 'guard(spinlock)' for plain (i.e. non-scoped)
> mutex- and spinlock-protected sections, respectively, thus making
> locking a bit simpler. Briefly tested with 'stress-ng --binderfs'.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This looks correct. Thanks!

Acked-by: Carlos Llamas <cmllamas@google.com>

