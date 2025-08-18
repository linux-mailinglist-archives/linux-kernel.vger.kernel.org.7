Return-Path: <linux-kernel+bounces-773308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B4BB29E0B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 11:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 023865E51CB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 09:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA3030E0D8;
	Mon, 18 Aug 2025 09:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUjLe19S"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0600A304BDD;
	Mon, 18 Aug 2025 09:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755509679; cv=none; b=Pug+u4Lhs3TV5pSijpKlC9ahqBVskv4qzAMwcN6hsKj77CMKkZV8NVxbUy2aaCrHdiDrPIYdUAB2OdcAxTBQyUkn2/vgg6WzmXALqVBd6GD9FuQ5BunH6gojLZMbjLPFj03u9yP5PiEsXnXS3hzgNGOJDNSBxZPEYUDEIf7peZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755509679; c=relaxed/simple;
	bh=60vbViMR8Uy+6kl93oThleRFTtzQFX1+pX+f2yZSrkk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ueSPh/M1DhAr795G09wFRHHwfwd5c6ftxF5p1in/J+EvBVBppXQnU/Bio4ZgSa/YETGib8zccIZ6yWJU8Fu6uvdPdJwapFn/Y9XGcUtoPhPNPJJJOT2ASWyhZhnQLzrYVSwPjDgaSTxvegrNz5IVCAsHNE9p1QR073hgVkOlp90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JUjLe19S; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-32326e66dbaso2703144a91.3;
        Mon, 18 Aug 2025 02:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755509675; x=1756114475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=60vbViMR8Uy+6kl93oThleRFTtzQFX1+pX+f2yZSrkk=;
        b=JUjLe19S8UW3YNqrZ/YrkEs2LseqLXEP2QoXop++jvV6HG5yFiousVHWjcK8y5bBGm
         H7ed9oKc1YtMC1vX6qOw2i77fGxzzF7BeIRKxGowZgXepTOB+pWHE1J4zKgl7ykCy5OM
         +dNiknLOaJLwQwfK33bRbKlqWRjo/+t01sFY6WGO+oIeCXlHp3KnBlnOWD2DdUs3jUEJ
         McABroyg64riIzTo1y7OVqYH/lc4XKmY+D6QEzxWUJdXL8QOueu1lfSuTlFTzUsvDwGw
         kR61XjoLiPGIXKdnfsD7PrIjJWJM5rliiOeP1EWZpKWUzy6XtmpKQUQFbTWUSvzMoDXr
         a4Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755509675; x=1756114475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=60vbViMR8Uy+6kl93oThleRFTtzQFX1+pX+f2yZSrkk=;
        b=ad7nrY0GriW6nUIonFxN+fAoonhAETcpGH0kwmRKf/htRWNl0LKIswJax3EcmAWzcx
         IIePvRitkS5GAtAz48rA2VI48xgPr24iysZMqCHfsO2ckc1vTk7jaG/TM4aib8tna4ZB
         yNGnvs/epivOcOr1Xj8O68T3KHHHPaKj9ZQrh+fV7yRZ6hmlZ2szEKVGUKWBz+1LFe8X
         w7P8ng7SSbEFSVEOtgiMIJ9exfozRwnnF+yyOJ7kK17wlRw/mQ5JLvHsf6ju0qeMaHRb
         VrDd2TQl0IX9fvueX+UcxC/+7GH2DE+89B+SIoX+pVHWa1MllPXSElfc9BU85NPpllty
         PmIA==
X-Forwarded-Encrypted: i=1; AJvYcCU5nnApTsrKm7z2spasDr9cb5e/XicHSz1xnyg4je029ThlOrDEGFtHVzXVk1z6xYVjO7Rayi+fGyw=@vger.kernel.org, AJvYcCVUPbj8jKZkk8mfpUHijmVXX0JvsPcNimdhDfP6Z50vOo5A9HSW60OarIyfJG7pjof+ET5loLgdYcNFeDpg@vger.kernel.org
X-Gm-Message-State: AOJu0YxMIC3gQIhzkZlDTU4U9IegpoFQ2r7OfZj9O2k4TA4247LpBmQx
	OuyBwYbfWUHZbiTACHEpKkqsObgdN8m2mc5AxQ268IQrMHUDk1BKw29U
X-Gm-Gg: ASbGncvYJmWSFy0Z+sJkXmK+cFjN5oeagJqm/BJ1VwFH14WDpsBx6IR/2eB0zmgKryI
	5COGikCfHxnsV7BzLf5BDho9y97lybmaHebDL4ArEKPyQiQTWU/Tvm/TomzbGa/WDjtPtF10Hjw
	bzueD+GH4WCyRSPU5J9wO7OIZ5dH4JpQWVVdJE07qfVLS3oXWMYMUjh1HikVyu+T9OaxiemRbEW
	jy5nKRpYfoi6a4UYEAYj7Ou/kCPesTq1gJtxY6znmYN9m4N+2M7Od5EYr8E8KM8GgELvZEeYnH+
	94fuwppoccgvdXb+LvAQeSFHO5XoqmgX4IEkq8A2gDvXtEZ8ta1GVVsc9d+OLwsb+2WrTSbf9y2
	S61MuPbbpbgUnIlOXBESiPD7TzlN/AxIF25LF+EIFBqQJqDsMmjLN4A==
X-Google-Smtp-Source: AGHT+IFf+8zELKXLnNrTHwU3uwOFmVF3ojyNrlULiylhfH6Vx8GnSmdVQWDD/kELqJPafmdTuOsPqA==
X-Received: by 2002:a17:90b:180d:b0:31f:2bd7:a4d2 with SMTP id 98e67ed59e1d1-32342122b93mr17625593a91.35.1755509674970;
        Mon, 18 Aug 2025 02:34:34 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c408:a82f:ebb8:7335:2344:5a58])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3233116f46fsm10859247a91.28.2025.08.18.02.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 02:34:34 -0700 (PDT)
From: Kevin Paul Reddy Janagari <kevinpaul468@gmail.com>
To: kevinpaul468@gmail.com
Cc: airlied@gmail.com,
	corbet@lwn.net,
	dri-devel@lists.freedesktop.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	simona@ffwll.ch,
	tzimmermann@suse.de
Subject: workaround for Sphinx false positive preventing indexing
Date: Mon, 18 Aug 2025 15:04:27 +0530
Message-Id: <20250818093427.42456-1-kevinpaul468@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250702161337.69943-1-kevinpaul468@gmail.com>
References: <20250702161337.69943-1-kevinpaul468@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

THe V2 of the patch was tested by Bagas Sanjaya
and Reviewed by Mauro, In V3 I made the changes Mauro suggested
Wanted to know what is the status of the patch

