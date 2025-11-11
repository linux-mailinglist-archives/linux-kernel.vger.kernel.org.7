Return-Path: <linux-kernel+bounces-895784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D19C4EE69
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 16:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 336B14E1063
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 15:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6484336997D;
	Tue, 11 Nov 2025 15:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SNlLhr14"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E362436B06B
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 15:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762876785; cv=none; b=SYlKUnqbOj3Hw4z+u8zNAnzOBHobH7+DtOn7mn4etqtV050HV6gjqpxmOP4ZLjPFWqUA0XOviMbuSTf+DbLwDRO+GHoTMiCu0jnFXRpCzKQig+eQUAYArmHSIgxPlrjF7EF6zRlNTdQR06REwfn2FmUzREs8vIuXipFw/BBvKLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762876785; c=relaxed/simple;
	bh=habJTKF16RvMb4wT2Ca8XzZv7/mDUr/0ZO9916/+b74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tWMB3drtfBsMjn6eVhfenjGXGMIfRD2VRi4LzGdmxsHcWn2T+AgjiUyMC8M8BUcMKllvFBUhpr9pJ00IBQQsbj+lbCjAYwLGCaKDszVConsKqgu84v6gVx485UDhNR/4VdyvP5ykHlyTa1HWJcGm5zZbToI2HxGZahLapJRzW/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SNlLhr14; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-343806688c5so2664843a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 07:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762876782; x=1763481582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yxUPOCNvKPTysd65QP5bQesIm/jLeHtY6ajy2P7dY2w=;
        b=SNlLhr14SXeu9Nm29cWfLt61TKcO4ilof6Cds9DND4+v1TcgqhvzE0hslx75pLgfhM
         IkBF18Do0EZr6VY/IyG/dZocL0y5hhD52y/jp7QZFWp/tBoDb1wCbVCb3PH0N6SqGNsR
         qqggbAJaCQKMSqn+3lp5qUiqMMliloedjGlyrj6bpRpXL8JzohMRep4Z0nlBmAaZSvvr
         KiGJWG/tMNdfLyH6gPTVCIrNhygHVAutgkvCyy5FSlABfPBb+tsZX4zx1+cw4To9rGGS
         Re6ZlcBGTzsAQIsnOGBw8DyxqwOoc397kuarQ2GeZs7E+kpExRtU9lDa8swOnqHGd6Oa
         QwuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762876782; x=1763481582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yxUPOCNvKPTysd65QP5bQesIm/jLeHtY6ajy2P7dY2w=;
        b=Ae7Fj5AQlhWl8hH111wbQVUbygwbVjz3v/fPubk+cW3wEItCLCZbBRfh3Z4t3aC4Yk
         5BJxpYzN/vJoN8+Rx/aVOPGvmJWcyLt+fsKXJiXbfA09OQyHAeJqgkXKcVnX0zR+09hC
         DBeE+mDp8RdX6MnUpu1yMlvcC7OzJkMSmL97j6BIyQcEyL7rn32cbdAduErJRlUyxaWe
         hDvV7Fi9JfXJnirxH9s8Yo0LM7N9aR2gFeJY/VX/AMmKnusVtnaC6XStHMwXR9a1jlSd
         fIaih3ccfmjYsSvD/lHIMu3b8VtW7yVyX2WuRX3BjAayDSWl2sC78iZrOHLe9Eu+lvbq
         eP4A==
X-Forwarded-Encrypted: i=1; AJvYcCVvZpp+hjyQHsQ/+786lFDVcnqyVwB0UAW/QZh7W77J957u3n/2JdBpX0uGMGC7jgdb24xbDw3ybVsid5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaGDqg507/76zS/VZLT1jkDyCelsiUB6mDBjX8+QrfWvQ4OHSa
	44WKL3WhSVR1YMZbkCpKGb6JcE7U/R58nsmjR1i4vQ56kfY/GWaRTDU6
X-Gm-Gg: ASbGnctdBiNBy2K9IRcGoC2DnAHAgp6lC1YLzNstZaJK3dWbpejdH7zoXucjgPtW0jQ
	7Gmdwp7Esa5OjpB5NBDZimCf6VWuyphnvYvmrQSg/Qp9EfXr2akHsxe9P1IPaheoR6Mvc2793+M
	oW5vKGt5BgZsKU+52q+8P/aNDQEhjlsjHoTg4+smusaY4xcQsgdGiqdHRy5ozpwoJAkvweFrEa4
	XluBON9ZhVLpYfhI9sqom+47Bsmy+q9l5MNBu2bfUBrF9fMBW6INq1pTum4+l6H8JU80hDzi+59
	xU8Gu7sCtpVlTuwz5mMH+LUl/LxM01O4J521+CMDadmMzL4ORxdQeDgeJLaBfiFsAu5ZcZbFCcu
	jT2nNRGLUTkmxmTUq/EGUduuGO7eWe64lhgGpainyKbj0wH7fwSOPznGhR1MR0s4tbPc/YxnHGZ
	cV2nZGQywcxSti
X-Google-Smtp-Source: AGHT+IFC4Tdv4hyC0tNbM7O93uQAh15b+TAWtpybJaAVqDU8Oixp5tLuF343LSPh44gXfSdgLhjKLw==
X-Received: by 2002:a17:90b:2788:b0:343:684c:f8ad with SMTP id 98e67ed59e1d1-3436cb7a9d1mr14655746a91.4.1762876782582;
        Tue, 11 Nov 2025 07:59:42 -0800 (PST)
Received: from archlinux ([36.255.84.59])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343cc803730sm2241280a91.13.2025.11.11.07.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 07:59:42 -0800 (PST)
From: Madhur Kumar <madhurkumar004@gmail.com>
To: phasta@mailbox.org
Cc: arnd@arndb.de,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	madhurkumar004@gmail.com,
	mirq-linux@rere.qmqm.pl,
	phasta@kernel.org
Subject: Re: [PATCH v2] misc: cb710: Replace deprecated PCI functions
Date: Tue, 11 Nov 2025 21:29:36 +0530
Message-ID: <20251111155936.2999935-1-madhurkumar004@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <629a4be58b02dac86d267fb00b8e44d7aa01877d.camel@mailbox.org>
References: <629a4be58b02dac86d267fb00b8e44d7aa01877d.camel@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 11 Nov 2025 16:21:30 +0100, Philipp Stanner wrote:
>Nope, this is wrong. pcim_iomap_region() returns an ERR_PTR on error,
>not NULL. You need to check it with IS_ERR or similar.

>Sry, late to the party, but just saw this. It was applied already, so
>someone should send a fix. I could, but maybe Madhur can do it faster
>since he's got the branch etc already.

Thank you for pointing it out but the issue if already been fixed by 
Dan Carpenter 
https://lore.kernel.org/all/aQITFDPyuzjNN4GN@stanley.mountain/

--
Madhur Kumar

