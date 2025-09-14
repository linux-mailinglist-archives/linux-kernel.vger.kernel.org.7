Return-Path: <linux-kernel+bounces-815557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F7DB56821
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 13:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D124189AD47
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 11:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F8124728F;
	Sun, 14 Sep 2025 11:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gTkjKwx5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C880E169AD2
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 11:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757850714; cv=none; b=XcEqptOIdGt1xZqAtaS/uCwjLsU5x62yFoWn8yDRKwZY6W2RBFaKD6xxXJ9Nu5Ai3fpYmG33WmI5QiXuT+ZZMxM53QywB6iGoKFlzgZ7CB1SkD0tWNd8KtrRubWYZju8CX2Xov3yjD0b7bjOk+UDcdsvI+uH/NJcsTrD8mQ9IvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757850714; c=relaxed/simple;
	bh=AIPYSOx0428xiqsH5Zw0f1PRbiXpWTgmcLOnuEvukws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UAd9rHOrNDdaaMGWSNJjiZtgtha8gTKg59+H34PrvrSFGvwLK2Bt07f5wV54VD27wFgAmebAKRsCGd3jpchnVZutnJptDyBr17OKiN/JWlA5membCazGxpP5sDV+VGA5qLzMfa8GvGhT3FQHrARSt3wAJB2OhiGlcPPxiJZzT1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gTkjKwx5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757850711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=05ZWoSoCpXTd7kMo2D7eZ+9NOL3Ymr4GMs5H07grvQg=;
	b=gTkjKwx56HG3L/6Jd8p8Zge5zRjHrLS1m4v3+nYZxqxyIOsbJYkcQtSR3FvHTV/3bAkH9l
	qxM5L7Oson5P2UoxpOILEXTUscojoy75ZahCLE7kV9Vdbu3LvHgZOVmSZxYbxRe3a4wz3L
	NfLO7jNYT+bT6OyO50CzINcoKHjX/zw=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-6VjYuVOXPBWJfjljpgpUrw-1; Sun, 14 Sep 2025 07:51:50 -0400
X-MC-Unique: 6VjYuVOXPBWJfjljpgpUrw-1
X-Mimecast-MFC-AGG-ID: 6VjYuVOXPBWJfjljpgpUrw_1757850710
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-827a6eaaf18so226569285a.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 04:51:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757850709; x=1758455509;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=05ZWoSoCpXTd7kMo2D7eZ+9NOL3Ymr4GMs5H07grvQg=;
        b=tvfHnH0lp13/4orBZEfrgpesm9sCgFqDtvOQFiWVo9vgz+tWIlkXh5Me7v7Gn39CQS
         PkAF5jpmcS/QQMxF7fNsoZ6Xq1vr5qkQwFg0SfbC0wK9o8WwQerHSUyL5xxkEQ84R5WU
         N345ZeBQ/UxsSKPr7XIsRKgSGx4r92CfeOh/N/AUOM7NffmMw0dwSOb5VJLbwvnqvkls
         OliFzafHbK2q7Br/7DU1KBnkN+6O8/3WBSUgSqMagUQyiLHy/lITG6XTWpsfQVHuZjD2
         1iFUYTTmYkAM54/T1OagFCSa+IF+IZV5Z9JGzgqtHCt/gAF3CPjkKbKuNtFfUF8KlI0A
         TFYg==
X-Forwarded-Encrypted: i=1; AJvYcCUburgc6HiMJqCkWAvNXCv9gGT/jdRYsF2ABYIonH2miGCAzdlMB6a85BXkr31PHCOmewn8pRYPE8k/PSU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsk+/cZ5m91ftlByRUAamq9jXd+POCuqZl8jUQO3OUeZp9rQC5
	Spfc61sZ455LQcyKtvtd/TL9Tmz1+xKdAqje7arqXUqhimGQkL4ieFmQfcXVOus4PzBpl8KLI/d
	MCMR0yw9gUohmcqHnw43qzqnethJUpXMO6LlRvwcQTv4ptBjMKDPLiMOdsZZMOICKrQ==
X-Gm-Gg: ASbGncuB0utscdjTGgMMTFUfc0krlWoxkeG7h1E+iCr9lkYYOA0/OvNs657sHOSyanC
	tdKatMcTSfdbWgujzMSBNniISUaYfbK7Onv+Npm3S5H7tVuP7V4W7Zq3On3zbbvwUl17lAYvuZp
	IlpUGtv67aX26xLESTuXx4FQFUwKIBtCx+r5MlJ8/wgT39T9bod2OtAObqZ6yjMwU/+tfx4aH5e
	TGuCFS+rzPRbiKXGbdfgc3id9hCul+0HgmyKp8FaUESmyGThCyFKZE3ET5Gprb0fFV321oQZsZ0
	TizHiQpqvB1gnke3Zn6YIgmFIOKgtQBR09A5DQSwiOodSN8mEK4yXn1yQmeMsT1sghsOMhpnORY
	xOpz0vu6BSIY3dP+EZTMtdJf42VoeGZI=
X-Received: by 2002:a05:622a:409:b0:4b4:8eb7:a461 with SMTP id d75a77b69052e-4b77d14bab4mr135163581cf.58.1757850709656;
        Sun, 14 Sep 2025 04:51:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHL+XRwnX6jGuwsu4a3hT4crD8COQvyH3Zc5Sbne0Nd2VMEI38oG/sulJqcdFsNqwfss3aWZQ==
X-Received: by 2002:a05:622a:409:b0:4b4:8eb7:a461 with SMTP id d75a77b69052e-4b77d14bab4mr135163311cf.58.1757850709265;
        Sun, 14 Sep 2025 04:51:49 -0700 (PDT)
Received: from redhat.com (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b639da9e99sm51613881cf.29.2025.09.14.04.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 04:51:48 -0700 (PDT)
Date: Sun, 14 Sep 2025 07:51:45 -0400
From: Brian Masney <bmasney@redhat.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Maxime Ripard <mripard@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] pmdomain: mediatek: airoha: convert from round_rate() to
 determine_rate()
Message-ID: <aMasUV14w0Dc1ki0@redhat.com>
References: <20250810-pmdomain-round-rate-v1-1-1a90dbacdeb6@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250810-pmdomain-round-rate-v1-1-1a90dbacdeb6@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)

Hi Ulf,

On Sun, Aug 10, 2025 at 06:16:19PM -0400, Brian Masney wrote:
> The round_rate() clk ops is deprecated, so migrate this driver from
> round_rate() to determine_rate() using the Coccinelle semantic patch
> appended to the "under-the-cut" portion of the patch.
> 
> Note that prior to running the Coccinelle,
> airoha_cpu_pmdomain_clk_round() was renamed to
> airoha_cpu_pmdomain_clk_round_rate().
> 
> Signed-off-by: Brian Masney <bmasney@redhat.com>

Would it be possible to get this picked up for v6.18? I'd like to remove
this API from drivers/clk in v6.19.

Thanks,

Brian


