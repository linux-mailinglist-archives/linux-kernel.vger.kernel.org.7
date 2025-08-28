Return-Path: <linux-kernel+bounces-789538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D73D6B39709
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 10:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98DA03B5698
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 08:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1739A2D4817;
	Thu, 28 Aug 2025 08:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uq5zV0Dg"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3864E2BB13
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 08:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756369954; cv=none; b=BhT3hDrc6aCnsKL2v1QVh51NQaXk9W4GmP0ztxYl+kfRXuP0PcUSqYaSIFVcX5KTuczJ0jzxGCgUQZHINjCVYhKugxjDkGkGJ7/OQYfvTDVDAj8w05SqzC3apX5F/FQc/JdHniYSiHoW964CPzUWLZpxLNUfWJpTU2zsnEuHZNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756369954; c=relaxed/simple;
	bh=jOss6MkhwjGpF1iOh14s08w/qSHb3yAql9v5qFr4hQI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tl2mrt5ZSbePyHSwnrPYhaBNF0yLwcUItSTiWN0Gt9u1pyTHOkRrI4yt0cCfcMFY5/SOBZi3wjEubzO9Av8RwV7RZVJIyS8Wn4CznVaRNILPheeCGziA5oDpo/2u77XUdlUfRm9q+nXTKwvfv5JZjREmM0pK3iRXQXefTL6kecY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uq5zV0Dg; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-324eb9cc40aso1459100a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 01:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756369952; x=1756974752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cMsawreydTlc4F82yKjrug0W8AgzAt83Q8ngL+wzgYQ=;
        b=Uq5zV0Dgm+l0gMmOUyDAXhBenTOKqdIkn4hv0U1QzMk5ai8DmmV/M0b3pICCFLtrl9
         wlDYwULOb4yND4NvGx81KSE3mrgvHkR6u0JFjNsnsBUhdGx/syi5Bbf5KyQA/DBkCLox
         t6D+j9WUYdvj+zvb6qStW+8KElY9JDF+Sfelrn7O0ZlNB4c3Zl1arZyHeTLwsAwWMHUn
         lk1zpTd062z7ec7pCx2GaDVdqYtIiu96Mtl/yLM+3LE9xDxvcj04rntFrxlGX5C8+IJp
         QR+fTt4ev0jUJB+T7d/Z1Erezf169Ma9Vfx65+Tx37my5EnHfyCEoLcsISH0txBsPogF
         l+pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756369952; x=1756974752;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cMsawreydTlc4F82yKjrug0W8AgzAt83Q8ngL+wzgYQ=;
        b=fqXlEVCLWK1V7GAOfoZVhseAmd+rjp+PgsdOlyJ7CNmXAq1bTJ6pkWBeivVzTFE3mI
         ztjIdagRmDk83telAYRclqq18AraJYfiDybMnDQVdVITrUHegYL2uzTv/Lf8uLau71Ha
         1XjW287GYfTLwDOD7g6/uI/x5XARe0xxvrzLa1vyLUagWem+AOFsY+wGITmENqTZ2zeR
         LRKxOq53IM98OLhZDr3TXgWg8lS/KdHon+hnGLmwEY8vBqTqapJj/43lDhMKL+ibGk5p
         UdSgpXjXNWJdoJ4/iE914LF+lL5nyLKUQMQdQvPL45HhVNFqFyO3RyWCGr67LANNJllD
         Y+jA==
X-Gm-Message-State: AOJu0YyJMEBwPKKRvVI7NKe6rRCGiKxWpXuRaEVVB6HmJiRg7BTD3Liu
	/BOTpk/09i7KFHxGiWOlcFyia5Gcq5MM8vKe+qDEJ+gsFPNJFe91QFki
X-Gm-Gg: ASbGncv5ZScXtULIbvYEnRLJOmhB+xQfeaUv3+p6LxINT8fkXMn5D3Ab+6kQLLBYeAy
	QwwA+q+kPCf7THvKYrV/L0HJo8QHvgxu+JyeWPCF2wKoEkHp1MaHoPKbW2f7LBwbvXeZT8YL3lY
	wxeBSjql+hWU7cIMBRL6hRYh5fML070nXY2banQQZCenCvcRSj/UsQhrVfutFNvkSCmIaRa3HOY
	xPMdxEA/uFmZxRWJJra8ru0J2XxGXChdRnDBFOVBs2rKok/q+YaJzHLzz4WO4dNM1GWR4eaMdoY
	dWxPH0H445hUbXTB9VhVtuCwbx0T9E3mJdQNWw6kdxTxtpVTIlU0SsBKWS/6QuSPaUyoscW70qG
	kARAmmKPkljm0dZ0+4jPH499aDBuZX+S+K6+Jopm2N+U=
X-Google-Smtp-Source: AGHT+IGww2Au6EwKzWJINCDM44/+WlrGxfz+MYGJXZ3NEBCM62zu0VwMJxkQOfq9y5AhbcTU3tjCgg==
X-Received: by 2002:a17:90b:5246:b0:321:82a0:fe50 with SMTP id 98e67ed59e1d1-3275085dabemr10455859a91.5.1756369952348;
        Thu, 28 Aug 2025 01:32:32 -0700 (PDT)
Received: from cs20-buildserver.lan ([2402:7500:500:7a9f:2e0:4cff:fe68:863])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3276fde4cecsm4335148a91.29.2025.08.28.01.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 01:32:31 -0700 (PDT)
From: Stanley Chu <stanley.chuys@gmail.com>
X-Google-Original-From: Stanley Chu <yschu@nuvoton.com>
To: frank.li@nxp.com,
	miquel.raynal@bootlin.com,
	alexandre.belloni@bootlin.com,
	linux-i3c@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	tomer.maimon@nuvoton.com,
	kwliu@nuvoton.com,
	yschu@nuvoton.com
Subject: [PATCH v1 0/2] i3c: master: svc: improve IBI handling
Date: Thu, 28 Aug 2025 16:32:23 +0800
Message-Id: <20250828083225.3558100-1-yschu@nuvoton.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Improve IBI handling to prevent certain error conditions.

Stanley Chu (2):
  i3c: master: svc: Use manual response for IBI events
  i3c: master: svc: Recycle unused ibi slot

 drivers/i3c/master/svc-i3c-master.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

-- 
2.34.1


