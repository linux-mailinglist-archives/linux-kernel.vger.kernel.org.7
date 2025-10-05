Return-Path: <linux-kernel+bounces-842323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F872BB97FB
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 16:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAC333B0FE9
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 14:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381D215278E;
	Sun,  5 Oct 2025 14:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vjti.ac.in header.i=@vjti.ac.in header.b="h5uEgpl2"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CAB41C72
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 14:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759673811; cv=none; b=h7gHAaFDytsSmmXwvRVsD+0XLYG5vH/s/W/ZAJ8PIafC0ktBf1ADaYA4ljjD9IWjgR7YtiIFzEBskT+pwF0cSWCP+LO4QZiO4SyS7JjTrJXPz6VoYZs6vj1QPvkPjaWfOzZNcOd/oF5cH4iYBqnNrz5/d8+lGJMeA5oWfTSzi4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759673811; c=relaxed/simple;
	bh=OdOPdNizzhcMK+2HVt/uNh54Txev+s4Tbp4dOVobb0A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ob3FNRibM4MD2woZCAhUnNXl0TkkaRoT9RKAuL9NL1tdlxbt9RBcdc6nFVLO04F7oqggm2JDerdwHWNfpo3xyREWMUkGirDIAbrMnsmoKIgdLzwqABfI28DOSfe2WAdEvWkHaADkMmrC9JC3ujdG0FrBTfq5WanMV6KPK2C1gWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ee.vjti.ac.in; spf=none smtp.mailfrom=ee.vjti.ac.in; dkim=pass (1024-bit key) header.d=vjti.ac.in header.i=@vjti.ac.in header.b=h5uEgpl2; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ee.vjti.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ee.vjti.ac.in
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-78125ed4052so4244343b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 07:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vjti.ac.in; s=google; t=1759673808; x=1760278608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OdOPdNizzhcMK+2HVt/uNh54Txev+s4Tbp4dOVobb0A=;
        b=h5uEgpl2yB4EHAKqjpixIm2xnEhctMF8HcMgDgugIwmteZjkHUELOyaFQdEk9oOWmk
         iYvvVceFJEYmq3Z1FIeq03IrmucVrfhA/LfKXkzQymtHkeHKcT2A2ymuZeA8HmM81rAe
         bTvFJq6aHk3IjVhJiDscphHyNv/d+tE1YTgsw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759673808; x=1760278608;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OdOPdNizzhcMK+2HVt/uNh54Txev+s4Tbp4dOVobb0A=;
        b=OD70Rltk0KRJvlgPWfe8l8OgTrYbMVYewu+BCboyPQfd3+MoqS5xgvv5btMlRqUKt6
         TlcP5z6t1PElt7aCuSc3PwhypDLc/aU4A4Wrscl90eO10LDaNL6BM6mdQWOF5zzeZx6B
         eS0d3ITnH9NsxNzPV7RRHIo0Q7npMe56ycxM38G1rPic614MYzyrPuNfVruoEE1y/2ic
         yRHBmJU/Kw9oiEmcBfSMS6JkKaf5Jwyp/Z0BzWguOUsyFQPS9Ud2dtJ4+wxovPO/k6RA
         UEu0HdhHJWLJKPXFp6nH4INeHDI8UvBer/qCZbCnijQKIjtqZ0aCXn8xwiTG+EeawxQ/
         9K5A==
X-Forwarded-Encrypted: i=1; AJvYcCXpB7D2q/O52imbyyO1F2RSA78UFU5mse3pdwQYo+PpQgzYU6vG3VfFGEqorUnBC70ugd4HRRJ0cKzntvI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywat4saaOV68Ct8jN0D/soHdsWMzpUZFO8qZFmZNsnw+/2kLIvN
	nK6C+/3DkkSKcSoJkcjMdsRNHA9gdg3I8RriOdhS04GPbWR6HxNDnkBFKdXLhvE1t60EQdZ19Wn
	4x5iapozI5Q==
X-Gm-Gg: ASbGnct250yoDN+0otQS2f5rgqK8t/uqa8w2+pyHPJ/7U5ZBoYS10HjZQZHRvBPoosI
	CAuy1L9ik/jkki2odTVqDtiLD3t6PA4hr7846gagkNWFIhVe0SQaJ+VYzuRW6Bnt9uC0s7S+ES0
	dou0sWcwa9e4WGjk84CwlmXT1diconKTAfV0ueYvfwfee7Hd0jdIz15CEJhZYYAzx0qcYGAwH8F
	ihP33V7USRSUJadVfZUNzAacsuxLSUONUo2iY1Uv0cgaWvVAscfILtmoiYGhj0/4cQiNKn0uxRZ
	7d+W2tM302oBiSDK2U4nuSRS3eMPBVV9VCjogwL3EC3b+TqbtmOc6YET6Uml0VYiTpuflyuj67V
	IQ9t97SxpNbUGI5ecw9iBAHlZZJ7dWtDXmhA2zuv+VnhaiibZmkOzzS1r4VDb+b9e37L8rAtQPb
	kmaeS76oMAAFk6DC7XpWuNBQFHaFY=
X-Google-Smtp-Source: AGHT+IFq1Q0QVyU5LNJ+52F14B8VFbcLSZv/AjIFhMVdlEtDnkad1OyMGdntVBJJaXnwHFLlEMTzYA==
X-Received: by 2002:a05:6a00:4fd3:b0:781:8680:3175 with SMTP id d2e1a72fcca58-78c98cad8dbmr10216182b3a.21.1759673807907;
        Sun, 05 Oct 2025 07:16:47 -0700 (PDT)
Received: from ranegod-HP-ENVY-x360-Convertible-13-bd0xxx.. ([2405:201:31:d016:a866:8cc0:feb5:15ff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b81760e58sm8301295b3a.24.2025.10.05.07.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Oct 2025 07:16:47 -0700 (PDT)
From: ssrane_b23@ee.vjti.ac.in
X-Google-Original-From: ssranevjti@gmail.com
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	syzbot+c530b4d95ec5cd4f33a7@syzkaller.appspotmail.com
Subject: 
Date: Sun,  5 Oct 2025 19:46:35 +0530
Message-Id: <20251005141636.12405-1-ssranevjti@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <68dafe35.a00a0220.102ee.003f.GAE@google.com>
References: <68dafe35.a00a0220.102ee.003f.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test on: linux-next



