Return-Path: <linux-kernel+bounces-738789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35AC8B0BD0F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 08:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D79F3A342A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 06:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0E427FD7F;
	Mon, 21 Jul 2025 06:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Unkg/GrW"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D7227FD6B
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 06:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753081002; cv=none; b=DMaZNFxBKaN5utxetBrgS17sqE5iWq2k21XY0gkvlwYSYXfyRf4cXbag29EVvjXxQBrGQkUDrlVk0G+Z6dCXnbnKVoOSaX9eeKY4gIq1gB/zTl1Ea9o/KRoCzfqXbYjf+DR4b0qZd3F6DY0R3N0J84PV4SVy4gK1FbkF35wOsvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753081002; c=relaxed/simple;
	bh=0DQBXq2HN/6qH+Y9jouZFed5XRHr7dG2MrXu9+Jzw9E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=caLiQlU670J8YTj1m+Z84MK98pCzf3nMWcEIJiDXoFxeHrCvArcGXhfyl5YQ7FQA1p4PyOA/DCPds9/dML14ttgm8RPrftEHJu08nYIJYRPK6DoIx9fFq0CKsQkHRA8xEPIaI80HwjbV18c0ODZTGO6/TmH2IB1BmHjSFlosGfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Unkg/GrW; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4ab644b8dc1so45175171cf.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 23:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753080999; x=1753685799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yQQIZUQ7UmKmkjv2gej5jBDOs0zZHuvpMuMVygz6yH8=;
        b=Unkg/GrWgY5SJiK8qnZxdkm9dNxnk0InlrBbaJc562JCq2AjazzuBqI4ljnkpWxZb1
         UTOnIDCt+r8ujqHw0muLF8cqBV0ZSprPtW9oXKUNdK9WF0gkRbddrUPJysvoMt5yEEyD
         ZJ7c3TDCvhGq3QDyMRVUPEQ52jeGzLeliiJJLMNu7lU5JQjHCHZ8ueKUKHbEQB3Wj60v
         1uQ6eD9gc5mxoY9CRYsTUFF8450t4nqCkRviRtbaR1q3Tg7+5cYJFdSBBVNfCkrp5AwZ
         eZrhClHO+cYM8eAON//3Awvx+Wfmgg2JlHCx1vF5WTVzDFQZYEeHsq5lNIC2WJmi0JXn
         NBcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753080999; x=1753685799;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yQQIZUQ7UmKmkjv2gej5jBDOs0zZHuvpMuMVygz6yH8=;
        b=BKMqB7HN0GgMqX+lMoLfTUQ0mFbOKxwbxXiPOCJuGzv1ZGuMBbujydPI82orYqz+el
         nLLMokoXmPxfDWSwz+i8gAeX5QnLXnYYixRHrH7dttW3kL+3ka+eF3aTPckDL+LIG1wG
         Zp6l0vPIFMDJdgs6lt7Z/eoS1uUT6gjWFYWgpllc8C87oBlZRdXuptS2x4ks4584fWuE
         lPbPQ2L9B8w0nivFX1lSRHjHNh+iMU2yKNyYL7w7/v2nLCH51O2Rhmqx28JPDLK5oFmf
         PRudkCGeDdikkmszkhBSI/GUs+Kub5rJ/U7QKkFEKXNlJ//pMTpkn1bKUGV2jK5fIAg2
         EWPA==
X-Forwarded-Encrypted: i=1; AJvYcCXHn7SpC4PInMBo+HbEtmgFBtfKmc9l3QRaogU5gtjpedamRwq4bBlv43VJCi7tIy0Rab26stK7eSroVLY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGIGCLFsS1wX9MuZskpx9DFpz0sgzEeLN12YN9tsDM9FlrhHz2
	CuP4NV0udxMhn09zVl+AH7fBF2VLFJL55+E3BpCOp3KZpFXrkjWKF8fX4RxmsinopWg=
X-Gm-Gg: ASbGncvwVUrHKU1RhbJcZfw3PDSkUxj8eL5p7i+PNdVXGq0TpADSiHVwNyxymkClj6A
	Ayh/TOfYVmvKKrhtNHQEdzCYjFDT81FMOTM1Rsp312VfCoDmFZ8hXO6NfhXrg2gAlnj6tD2MaNG
	AzmFlN48Wz7DEw9AvR5UO1FJKYkHeMhbVrxiUGoC/mrwD+RiZspuD7pElcz+gtSml3DMT3UeP7m
	KUn+5Zk8u/Tm6aiKK9QiSI8kKlxoCDCqyVkq+A6BIQeP+VikM4xYh+ioECzv+QYBR74FRB1+1vo
	wr+BfvV7iTqqJAyHxrkGb/wZYNgfZovu8ec+QSr6zarTjNimowCjheId7KoJKQF4HpUkRC0dqzC
	z/ROYsXwnl7fbSKUchTv8ajtpsmeZRDbrmQsqZzUPe/o/IKOjgOE=
X-Google-Smtp-Source: AGHT+IGkllGgVq7+POAScPebihOJ+wo8Yd03YccxYtdX0vB/pY9isPBmAYjxxVgNa39x+HavQXdN0Q==
X-Received: by 2002:a05:622a:309:b0:4ab:a8ed:5be6 with SMTP id d75a77b69052e-4aba8ed60f2mr318058371cf.39.1753080999367;
        Sun, 20 Jul 2025 23:56:39 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4abb4af44d7sm39127791cf.38.2025.07.20.23.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 23:56:39 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: vivek.balachandhar@gmail.com
Cc: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: Re: [PATCH v2] staging: rtl8723bs: clean up redundant & parentheses
Date: Mon, 21 Jul 2025 06:56:28 +0000
Message-Id: <20250721065628.297870-1-vivek.balachandhar@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250721061412.297554-1-vivek.balachandhar@gmail.com>
References: <20250721061412.297554-1-vivek.balachandhar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Thanks Greg — that makes sense.

I'll break the changes into a properly versioned patch series based on type and resend the v2.

Appreciate the clarity!

Best,  
Vivek


