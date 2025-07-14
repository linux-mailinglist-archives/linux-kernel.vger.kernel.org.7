Return-Path: <linux-kernel+bounces-730386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB97B043DA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 17:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67C227B1601
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AEAD246BB6;
	Mon, 14 Jul 2025 15:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="d0Ba4E2X"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B90254848
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 15:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752506747; cv=none; b=CrYIa1MK3NxSLzZyQ/SroVjwMjp+6kB6EuPJWPFTnwNQ/R8eckYQiMKyqG0HYXoXZ03qALtEGnxLJ99ad0p/MUrNPRenfLgHAkUi0N1JVYpgoYfQn6++DjqQEckfzK4IsoiHXjPSE31+VWBAa4OxXISq1rI9InBJ4u0wjrtWTkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752506747; c=relaxed/simple;
	bh=D/Wj8AsdkHqTWNaaXM8tQekTCQ36OzCntggY/5Khy1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WgEIlH8rsVhixPvROdcDfCJmiy6dSlv7or24J7U7FmG2d9CqcMbSK26Is84sbmG2hqXCWSQ1r7W1YazHUOwbJjXyXXv7DcdtAJeCGLg5Zgmd76xnX2ISpErIi4pSfRad5kau+KKLCTYzpVnGPRftCvWw6QHrnhx25QJ2KqOVY9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=d0Ba4E2X; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-702cbfe860cso42905036d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 08:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1752506744; x=1753111544; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4zjJXXLh5+tZigrmWR5HYIKk25Y2UR8qF+dPi0kLozI=;
        b=d0Ba4E2XJalsfqW2mZ7eOszM48fujgxi6LCSzw+RItXxqaKdshvbhdxQhj2V4YZBl8
         JWXv3KRqrVQ0UgVKbsRlmOjca9rJ4hd7AuEzRQqhztOr5AAp3b17r9QUu3quZpBgJ7P9
         rt8wxFzpF7J2RKTFVj0pgldHqchMO6Q1YjBek+Uf+7pCwoHZHnXtSI0+iUHxQkp06MPp
         rdCmDHp4B6oTa7p9lkZC/vjciqorX9WoXoli9JeXZLSr5D7KqWK+JpWMEoYzYe1B6p0o
         nZkJiaC+rGTKq2H45XgpEqS4mK6epzCwlKcoDaxTzHyZ97p83BpxfmRx3t4yjSgMfcCG
         68yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752506744; x=1753111544;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4zjJXXLh5+tZigrmWR5HYIKk25Y2UR8qF+dPi0kLozI=;
        b=M0oQNrn6WUZMNOFHdMQ8dNO3H4BKlynrKUcNFIj61U1lxlVBbM7nCKgB6DsCv2PiBm
         vZLcKuV/Br9GKpfgAwatR2jBXDwfJqJoU9pt1plHqPpAbGpitu84GRUvywg/hJfA1Nkc
         HFFOlOHb2Obym6EQ2LLUKd2vkdwlEpuN39rxpxzxnFRyEJAHxil4Era6Z37WadSeInla
         no4E5EGNFs1ZH0JxxCUu6hbbwucVJrWkjcZQKpw6kKmkzv26bKMQv6pbkGtGp+NdN/1Y
         Qpal4uLqb2ir5ma1OA4KAIwLaK92hd6WtbZkwVr0zWlsYE2xLSLFUgt5coYurz0O2/oE
         2TIw==
X-Forwarded-Encrypted: i=1; AJvYcCW9QMzKoolvX5oFoirF0LsSzyFTp/i2DLwCzujvwBByShsbDQVDHxdsaJFR/pGZKNdEO9UeaCwwJ7IMbEo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+HCvaLXNqxZGMKqI05nxOpbW9Br7IudNPwBiO0+KpgD3dg+Bp
	JmDXm0rq8NOA1AoGe0HjadUtMPkBqLyJGG39VONovbQE+DY0UB9ZOyKylC/mvJCfSYw=
X-Gm-Gg: ASbGnctIZWB5paFNmh/RzglkELynJIrvTiSJdkF1r9LoO20okyM05dK8s9eXkPGv3CN
	UbL7fp+mxxh1za60GlFaIAyr7QR2VSrQKfZd1NFyxFbQCGg++IowyctArK0YqVkkXMZ0Oxdd++n
	Nk8uW22ldxjEV0ttef9+/TtTF3Q+TPRIFFCj2HoPS9T10SkZ5i7cEh5bsZpAcEaCamJKdoh8RoD
	78WM5+eZyPXKPscFwg6vB+9VxgUaI2xvg/fGM+HIt1OOsr1yo4u78IjcmDChU05H8xX78bGnGHk
	g475wuReYzTwQNMzDUAI/bDQy4/jiYJA3JtzCbSTkZcoVGfYszWnFKxlsU23Xhb1ZeXNWZ/ekvG
	SpwykEyhOWsTELLmcwXd+nA==
X-Google-Smtp-Source: AGHT+IGbamWt1AigSEs9ivKOwpf41eWX2oLFFTHNBKRPHLRWhi9iVPDjxP+wb0xJDZlOHCzLCGEF4g==
X-Received: by 2002:a05:6214:519b:b0:702:daca:9038 with SMTP id 6a1803df08f44-704a70175c0mr227046206d6.22.1752506744629;
        Mon, 14 Jul 2025 08:25:44 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:365a:60ff:fe62:ff29])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-70497d895eesm48174306d6.96.2025.07.14.08.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 08:25:43 -0700 (PDT)
Date: Mon, 14 Jul 2025 11:25:43 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Hugh Dickins <hughd@google.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@kernel.org>,
	David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: skip lru_note_cost() when scanning only file or anon
Message-ID: <20250714152543.GC991@cmpxchg.org>
References: <20250711155044.137652-1-roman.gushchin@linux.dev>
 <8734b21tie.fsf@linux.dev>
 <21100102-51b6-79d5-03db-1bb7f97fa94c@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21100102-51b6-79d5-03db-1bb7f97fa94c@google.com>

On Sun, Jul 13, 2025 at 12:57:18PM -0700, Hugh Dickins wrote:
> [PATCH] mm: lru_note_cost_unlock_irq()
> 
> Dropping a lock, just to demand it again for an afterthought, cannot be
> good if contended: convert lru_note_cost() to lru_note_cost_unlock_irq().
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

