Return-Path: <linux-kernel+bounces-754532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D081AB19685
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 23:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCA36173973
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 21:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F451FCFEF;
	Sun,  3 Aug 2025 21:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iwhjm5F9"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D425835979;
	Sun,  3 Aug 2025 21:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754258288; cv=none; b=AlkrVKwTXoSVsKsGbfqTDhLlZzmICbQv+/hzSd/W6lwRela+9c37tFx1iUH5Nc+K9oDH9g7NvDaQFsUz4n63nMrZvs1bEJFTstpv1hnboTOuyJgIhweqeQ7uXTsFKsfoeunV7Ih38Cm5CjoHCdXGdd9gJGXVVgsVfeeI3bn66P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754258288; c=relaxed/simple;
	bh=KScgjEjsYn4d/3WtWzCLR0bYXohRV2w7laaiWzW0EWo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pQIBjtYfqUPUlZG5rOJSRS1+5yFyXsPFRph9j0x0sM0VU7oh+tjTCui8Ekifz3MbZBlLvtfU5yzZ5vCOnf3Y5CoutP2agRCB5NpsPi1BDFgz1fWm5Rq17va5nc1DXGXfoAqLGhPGK4vcbC0tbMnmHWhjcwO0JpASusSk3ixL9X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iwhjm5F9; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3b7886bee77so3289419f8f.0;
        Sun, 03 Aug 2025 14:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754258285; x=1754863085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KScgjEjsYn4d/3WtWzCLR0bYXohRV2w7laaiWzW0EWo=;
        b=iwhjm5F9J1mubJ5e2mdRtbPFoKc6PjMDN0KA1c+0VYXMHYKQBGhzvZcoQDDp+kRZFZ
         RWlV9qc3l49dZZRXbrfzXdfbsL01pZ/Ea1h2OmpPEJL+CIl4T0cOEgyDulj0B2sC75PT
         fy/wqB2PXtoS3Ywk9BOx68Y141B4Sv6QgqWuof7Cb+JpBJFWjnyERsFFmctDyO7BWa0m
         g3oNqdpWeyPrq285BFXs2AfZFhrDAA8iEYIe8OoiZ66AfNyZhPslLfHanxJU540kpauH
         650+BvyZmmLiWfMwXCEPO+ijrVm6iq41Pm5xyCeHqEDIALMs2FlU9eFRWjs9gAwrF/T5
         kQDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754258285; x=1754863085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KScgjEjsYn4d/3WtWzCLR0bYXohRV2w7laaiWzW0EWo=;
        b=NURpjJ6Ov69Oq3wxoRFow7948GaJvNZFL0vtNukOtDafKoqQtw4vP8CmGHEOtq3/mh
         m16hHowzd6FrEkRAekmVi92T9CEva8YDc7vPJMtxzcKn8zCD+KePaM9pAvIjYd859LnD
         wfJWbXls03VDzD+AOBmx75n6P03oJQY9WJXXOizjR6CaOFiM9V0W3buoltAxjadgtV9+
         YrXNveLeiKT/Kzeeih+Hem86u9bVhnRfYBzAz7tASRHzvDCIqQnzhDcaMFrcD7eqI0dL
         /L1xclqf3LslwgmCpySYpTlw1Y9FY/yvI212UCm7f8EEqKVAAQ+PZhF6tjmOAJojQKSA
         fZ7A==
X-Forwarded-Encrypted: i=1; AJvYcCVgnI+AECsw5b0lCIidiXAanq1Fcj1IJiX/XVmUlz90bpxmCEzaglfOZ9JCfmurwPsmwAUhhneddul4Ji4=@vger.kernel.org, AJvYcCWlOFbbUXJUhtdAK7qUp2DFfeZ8hmYF/3j/NNJzVGLilz9AGlVaxON5C9NgoYzoH80UDk8K/j6ZbuKA3Ng=@vger.kernel.org
X-Gm-Message-State: AOJu0YykIFUB3ZIoeQ5g3WE7fbliorHXhNEqdOTpIQ+92fEpotVeRxZi
	rGeKiJrT2e2ve26FPdzg3yc0hEUYgekENHJTHw8M0/MwwtuVtAuBVmRe
X-Gm-Gg: ASbGncvOVynA9RGjcCJ93qmEO2cYTTfSKs0nZ5D+kG77VdAn4aisp7zMSOxbUTCtrE+
	MDF9QZiJd7GJfgB1TUuDO6zEJYNoM/Xd0FV0uAqT3AEptOiKwBkFUz+1aAmiR7ZLAtjw3k+kKmg
	XXwg/IUpSCGP7LojRhoqrdZ9slFJRRRVDml5ivumOI7r5Dr6x8N3ZjwZDQKfACWTVtbQsBya2v2
	J5uVpDZSvAYcJyWt8vOAB8bqF3KVrldRNNsRNWwK1CLuj8GWxz9TRvAqLkVWMiTyt/MX6YWmRIn
	/A+KTJ/gnqnHz295F9Sjp5PNeq//FL7vX0IXEKuyR6BVgsnCISyoN38m12W2LQNkUftMHnTHCS7
	Q6ZYtcZ+4k2LFlDmp9DXXpsQWsxZ5VUs+Qk/xCE56ByQGbXen0m8FqyhuhEeuP3OnXvRCzGrb/f
	3c2Iqa/W0=
X-Google-Smtp-Source: AGHT+IFvWTSc1IUpSqMOEZV+NhVx8BDztCMcg2nw9ZLG0h7nlRsh9+lKIRTYLflsMzrBPX/fTEbSIg==
X-Received: by 2002:a05:6000:2903:b0:3a6:d2ae:1503 with SMTP id ffacd0b85a97d-3b8d94ba11fmr4178782f8f.34.1754258284921;
        Sun, 03 Aug 2025 14:58:04 -0700 (PDT)
Received: from localhost.localdomain (93-87-121-223.dynamic.isp.telekom.rs. [93.87.121.223])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4589ee57c18sm144832895e9.28.2025.08.03.14.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Aug 2025 14:58:04 -0700 (PDT)
From: =?UTF-8?q?=C5=A0erif=20Rami?= <ramiserifpersia@gmail.com>
To: gregkh@linuxfoundation.org
Cc: arnd@arndb.de,
	broonie@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	perex@perex.cz,
	quic_wcheng@quicinc.com,
	ramiserifpersia@gmail.com,
	tiwai@suse.com
Subject: Re: [RFC PATCH v3] ALSA: usb-audio: Add support for TASCAM US-144MKII
Date: Sun,  3 Aug 2025 23:58:03 +0200
Message-Id: <20250803215803.28840-1-ramiserifpersia@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025080341-usher-tastiness-0507@gregkh>
References: <2025080341-usher-tastiness-0507@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> The driver version makes no sense when it is in the kernel tree, so this
> can be removed.

Hi Greg,

The driver version was being used in my GUI Qt control panel for the
device. It's not a problem to remove it; I was following what the
existing GUI for the device was doing in other operating systems.

Thanks for the feedback,
-Šerif

