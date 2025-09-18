Return-Path: <linux-kernel+bounces-823029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B183FB85584
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 16:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5BE9546CAF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 14:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8E5302CD1;
	Thu, 18 Sep 2025 14:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JYt1nIhR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E96830CB39
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 14:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758206866; cv=none; b=USM/Qe636CMLeK2hZP2/rkRy1hsvYzoWXELh6egD9MGrBzgsTtLGKPInl0IKqZqTJL2d1wDU/mDdtl8n007r+64OgUFzl/cf4VFwApWI23BxiIcoERVOWZh20SB78Jr8SySkFSeHDjK7LXDpjNwdoLKLhyIbLUJyE/NfOTjrwV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758206866; c=relaxed/simple;
	bh=Lh4MiRMRbkbKmKC3uuidGIVYY8cf6n4fLdM2W0jOLg4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d6Iwpp0ecx23W/IUmB4MR/7t3OGUutY3whdk4mfSlFP3T07TGPKIAkU10t40x2fUHYeRLU/B1Fv8427cOrdXroansWIB4bBSkgKLGnyZGK6UNKGPP21Rg4PcUm+Ea2xoG6Ge9+rVFAIp13PaJG1mY7l3inJ1bF/UY86hbTFUmw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JYt1nIhR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758206863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OhiMvc2HqXTzwHfJUSrL0Ll4bQ9Pz33kYbXCvAgJfSE=;
	b=JYt1nIhRX0odoBnqQeIa99Hi0xgP2Xry7YdJpr7LSdkgLKuSjDS3iIPdsBQpPgPln+L8/Q
	1PthBmKF51GZqujCJOy+FL94PvuWqKJVvY/dxlyC1IHrTrKJLdDpyzGCn8rxfPt8zh3toh
	sy0ULRokefwYCEDcaDyW1tdPG9Gq53A=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-PWEPprmaNI6nSECl4YPrkA-1; Thu, 18 Sep 2025 10:47:42 -0400
X-MC-Unique: PWEPprmaNI6nSECl4YPrkA-1
X-Mimecast-MFC-AGG-ID: PWEPprmaNI6nSECl4YPrkA_1758206861
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3ee1317b132so398942f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 07:47:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758206860; x=1758811660;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OhiMvc2HqXTzwHfJUSrL0Ll4bQ9Pz33kYbXCvAgJfSE=;
        b=m6o/JUdssJywj6scgmJ80RboXprDFjAl5gtBGfDU6+9waoYGgWMQ1psy5tfaTR86zz
         6rgmyBfPcD/M8/GOFvE/RXYk1c6N3GnvKKWhEorVMDgoPJemqOWmc6FQY1pI+9fD56eX
         yftyVBKrelWn6973avKzUf5eyzeulBj1ZsvArzox2wqxYMjBEk48T7BsHrGbeOgfcVqM
         0VFpshmov/t8nLB35AgFc9k3hP9WOI0vsu7iBvvN61Tcge/eItNsJFu1VX7T82SY2ORA
         +k15jY26hBJCdben3yh7FuvGwjA+ewYnlIhNmZQQv18p39zCg80XH1Xx6aS1fI1Evd0h
         f7Dw==
X-Forwarded-Encrypted: i=1; AJvYcCUlECtD6UPKgn47RgUUk1C6gC0sAW9Hr7RIqY31Rsfk5cBIu9U7FxMbupbPlt7dQ0mB+W7QGtCnq+b5EW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwllX9jAfphIlJZCm2nCI4hMAOeuXbjIasbXjk9jAYPt8+2tlja
	TPq4wolOBdLjI5Ocet2/xP29FsqCR/04m38HdO6O4Ij6mz5mA0qxyza4TmQIIAFOeZ54pn/+Bwv
	9yQK0KoZI1IRdC8sIJKh6VsvF7vcuqPXcQA9qyVhd8EwJFO2d28j6wWAlxFsz9yw9YWFv8DSeip
	2iFraI94vZxgL1BysOcABp3Rbp5txOMgs5HY3IinjtZX6E4p7HHA==
X-Gm-Gg: ASbGnctlill8ct9Wo2wXWAWKgsLImLqW6wDJUbY+zec+6C2qXnwJVXra7A4zlQrt5+K
	kNHJvvl8ixkG4bwGU/+dDL3xahJr6zErJaZOy/TzFNNGQO1R0tJ7FRCrRAMUXGcuiWrVLBdERG2
	eYsH0H323rtQBW5796JYlIENWh7G4yDNwxGgM7qYTRq9IgExq2jBH0Bg7ynGdrxblETwLJKQaNU
	hz+7UOnxS3L3Gne4IJ9Ov4Jl75HPjVzh+ffarvU3a3F9ggDNRuSBEZ96Iqo0XCRHJ5eKyDQOlWH
	zd3P3DmVucy25Cg8gNJd0RHNC/2GxIkeKa8D3WRpAmUYFWNt/tXN0Z9nDmz0tpA7gjlVxRAEXo+
	H2gNbR6TT5K/G6OlLDvor3pk3
X-Received: by 2002:a05:6000:25c2:b0:3ec:7583:3b76 with SMTP id ffacd0b85a97d-3ecdf9c27cdmr5735899f8f.22.1758206859891;
        Thu, 18 Sep 2025 07:47:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBjIG5hUBCMKpDzg7l1tvOCWzjfPHsXfJ/x5BIdWIhj7nCFR/zFto/HYyCiMOl21k75DV9XQ==
X-Received: by 2002:a05:6000:25c2:b0:3ec:7583:3b76 with SMTP id ffacd0b85a97d-3ecdf9c27cdmr5735860f8f.22.1758206859447;
        Thu, 18 Sep 2025 07:47:39 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f3260a1ddsm63230935e9.5.2025.09.18.07.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 07:47:38 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Thorsten Blum <thorsten.blum@linux.dev>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben
 Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>
Cc: Thorsten Blum <thorsten.blum@linux.dev>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] completion: Use designated initializers for struct
 completion
In-Reply-To: <20250911103005.1341545-2-thorsten.blum@linux.dev>
References: <20250911103005.1341545-2-thorsten.blum@linux.dev>
Date: Thu, 18 Sep 2025 16:47:37 +0200
Message-ID: <xhsmh4iszyfzq.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 11/09/25 12:30, Thorsten Blum wrote:
> Switch COMPLETION_INITIALIZER to the more modern and flexible designated
> initializers. This improves readability and allows struct fields to be
> reordered.  No functional changes intended.
>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Reviewed-by: Valentin Schneider <vschneid@redhat.com>


