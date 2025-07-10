Return-Path: <linux-kernel+bounces-725586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A2AB0010F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 14:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF9901C86FB6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 12:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF1E2571A5;
	Thu, 10 Jul 2025 11:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IivcJTmX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF292566F2
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 11:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752148775; cv=none; b=kXItk7ddiDML1J83QYKM7BcNjuE6PMADUnWdUBMqT5JPJAc+Xrb9m9C+K1iVdKGGI8VmBxCLGQuyAgHpjUFfeN5DF5qc6+znxBJvUFVnRy3nqolIn7DFwNcCINn9SwcC+gBjS/0OTSBhUbxMhiGzDrcDsQmmfe4w1kbyrrHVj9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752148775; c=relaxed/simple;
	bh=65BBVRM+9o3xT9ml4F7bQ9jYjsDq1MfQI5WmoXfTQ1Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=R2j+AMjqQvXv37QuqxwGTQOIP37wvfYNbVTpWf366+OhFWhhOa0OTMxAsd894t20ig8WKZcmZ3HjU8HsW2YpVLKjvtmXAGCIMhdHb1itYRhKoskAmvEYBVpYSWbqhR4XqLpmKwHldaWNgMAZta4eTxzNL1FU/bHQDlUfuV7hbw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IivcJTmX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752148772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ahoQBElSBkoxClyth9k7MWOdW5mJ9+hvXOXZAB99bGE=;
	b=IivcJTmXqfFnh0HtmJ1HffwvAwNkAKGNyT6BDFH4K8nM05efNyNYaJDg1El3KM3zjHJlyq
	JL2HeqKVimvGgK4vrCk/ZRPnmOUYlQe7+2Ep4pri2qkN8I0Lfziy6qzD1djq9OnMn99NW0
	VBkZhqw5r9SVvfJfHqYcZW3FD9FgeVs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-hmcllAUTMXG4HLKEUP7Ozw-1; Thu, 10 Jul 2025 07:59:28 -0400
X-MC-Unique: hmcllAUTMXG4HLKEUP7Ozw-1
X-Mimecast-MFC-AGG-ID: hmcllAUTMXG4HLKEUP7Ozw_1752148768
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3af3c860ed7so472931f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 04:59:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752148767; x=1752753567;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ahoQBElSBkoxClyth9k7MWOdW5mJ9+hvXOXZAB99bGE=;
        b=cmUxKytqQJe7V2DYhTu3AvXvOcG1jiMR9bVoG49Otx2UdX9KLBJPvmkiY+N2WOATE0
         uxqtOYL/VTaJ0Tjrq5U/7T879RopwaZSMkiYB8f7cWrnSqJVTj/jgU+udYJLzuLl1ppK
         WOTnGiiKj1PB9ARRjQSyLeYfIS8FBXChHZSAL3fvjbNy5XuMoOjy23OXFZpnZ1fDGYt3
         XvI61fh0lbSMM4ZsABwsNdNpSn4EQBOz8+vKeCmsBenF5p9ZX8EJ18nd+4K4uY3MVHrp
         iAnN0bw8No/Ur9agL6MHJHiO5tSLssJ+vEn1sugy5Ka5832M3ZAuhVW5scnK9riT/JgO
         wi1A==
X-Forwarded-Encrypted: i=1; AJvYcCWXpOJKiG9y5TR6MpBcWqnrqabrPG6HyjgNoucsSCUsYk7eoq0LFfPsw5l37oIMdUJD2zobWH7SSOD2ZSM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFfwhDqvtCryBusk9FyHrhGvM5g/7zbNZgfkB3KukVqH6RY81W
	I+3V7RzUotELe3WmXgkv1idCONwIY5Gm43Nq8Wygpr16rqUHCtvPK8bnapXZzfCobY+DbAA33Cd
	3VY67dErfw3MyuDFxEIhMD9MCHs6D//znCtPE1sNh7IwT5Gt6+zEgbk2v4vb5msXQyA==
X-Gm-Gg: ASbGncuwrt5UzlKGpm1O2aqdo9/zpIepZil8VX7yDePVcLoOWhC9f6YPeq0P28/H09a
	kgCanuttRsq5RvLeU5NRziT06B1niyTjXny/cZwMFNWEddlOgc24VgLE/ExEavS5EQV+feu5frf
	jjaB/LiQsgJqUCtFS1ZEY0r66KIOE1N3D9K3vDKYGQJEPy5SUI+tIL4haQG0yraE5ezlY6lpfI/
	3B+b6yjsI8biLUqGgZjExlEbKgxnlofv7QJU7lJFa9hurIlVSrlBRLKY7CDeKENYKFbvglAVvVl
	+MY4ASZbD6BLQK6oLpNR9sqcriI1ZT4YQRm02K+a0+dnP9n1pkdvm62YfEbLvCV4fRBCPYeXSve
	o8yNi
X-Received: by 2002:a05:6000:2311:b0:3a5:2257:17b4 with SMTP id ffacd0b85a97d-3b5e86f332dmr2114979f8f.55.1752148767608;
        Thu, 10 Jul 2025 04:59:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWZ9E40Bru2XiSfuU6A5MGnXozhH325B6msi4rRi6AGGZE+oN2kmV9ZQ56Dv1ZEuAPjzICVw==
X-Received: by 2002:a05:6000:2311:b0:3a5:2257:17b4 with SMTP id ffacd0b85a97d-3b5e86f332dmr2114963f8f.55.1752148767186;
        Thu, 10 Jul 2025 04:59:27 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8bd1924sm1737197f8f.16.2025.07.10.04.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 04:59:26 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Jyri Sarha
 <jyri.sarha@iki.fi>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>, linux-kernel@vger.kernel.org, Devarsh
 Thakkar <devarsht@ti.com>, Tomi Valkeinen
 <tomi.valkeinen@ideasonboard.com>
Subject: Re: [PATCH 2/2] drm/tidss: Remove early fb
In-Reply-To: <20250416-tidss-splash-v1-2-4ff396eb5008@ideasonboard.com>
References: <20250416-tidss-splash-v1-0-4ff396eb5008@ideasonboard.com>
 <20250416-tidss-splash-v1-2-4ff396eb5008@ideasonboard.com>
Date: Thu, 10 Jul 2025 13:59:25 +0200
Message-ID: <87h5zkfe8y.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tomi Valkeinen <tomi.valkeinen@ideasonboard.com> writes:

Hello Tomi,

> Add a call to drm_aperture_remove_framebuffers() to drop the possible
> early fb (simplefb).
>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---

This patch can be picked and is independant of how the other one.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


