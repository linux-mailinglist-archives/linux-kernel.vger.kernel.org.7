Return-Path: <linux-kernel+bounces-798847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DDA8B423D5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 16:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31F0C1BC2D83
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 14:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA8E2010EE;
	Wed,  3 Sep 2025 14:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cm4hdYfY"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFA01FBEB6
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 14:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756910140; cv=none; b=JU+0FPtpZ7QUVy7Vxu/bE8lQzc919FqXoj0beZSaJg8cD8Assc5YblYQFmv3CW5Gq0khKZr5sJsXu+FA2vI9OLLGIRebL8srOQbatBqjenImtwtlQ9782uhyJIf44uVmc+xJdeO2FMnfuFku1b7ufKwVYTQZbSpujXDmeI5aGNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756910140; c=relaxed/simple;
	bh=jVOCQm4f//RwKtVl0N84q+HV1I03v+Sq3JBRFuKNe0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PDIO6wDM+3mrxMAhsA8M3qQ4h7G694H11m6g7WjUYrCGilV6GvhNvwv3VrPE4exvuw8tRXm3P/C9NJzCkXCcn4+zgTS1hSs3I67sO49rnGH1kqq3rNC91DtfXyr33RbN7IuuKi0LrUDS03cqxHC+1oKP5KBngszeCTrwsqqaH1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cm4hdYfY; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-61d3d622a2bso1352790a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 07:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756910137; x=1757514937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jVOCQm4f//RwKtVl0N84q+HV1I03v+Sq3JBRFuKNe0s=;
        b=cm4hdYfYsp4b7mhpEr3A2a8PqJkijjRAJpM9elJ5RgTl+2kOwmECW9QKDwDw8rp1oK
         fa2sF7xD7hfKxcG5KAv39r2Zun31JJadXCyUO6mmpHUBBIVPrwjZM35ENcfelOusWsnN
         i1AjyYaidx0OUg/0iqdqWtu8+h74V5YnK7CrhCfoFv4vPrklaAsoBqsrZBog2YcEzuI9
         VOVFzjp1u5Fm0kN+ZB1rxWCXBbnlFz37wKtF/gYst5UNxmMsjuti/S3VN+X2w+Aaoi4c
         VkHVvNIlCWoU3XE8W1m+ZmG053DIBf64cwM21UwB4ElEzZsolXcV22UQiHKjOYC8Thnq
         1/Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756910137; x=1757514937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jVOCQm4f//RwKtVl0N84q+HV1I03v+Sq3JBRFuKNe0s=;
        b=Q8ORbuib82N9sWh69mM4ZAnf+gx42tjW14WFfsXPwZGVodNhh2FBk3VvCfSS2Q5EOp
         7hqr+21hnuO5UoM00xE75XJMjuPYu1HGeZVdJlpDsqoOookt2iZF/ru14y7d9pZdmLVc
         L9+ZovmQyDqGl4RSTMBwORnaRDLg0TzgtIAkBz6g7pWqfH4aBB2ngHuJnAVDX9ZuYoW3
         pnG8frdbG39j7LA0U+HC3iCh6H36Xg+RTSZ0onGJyRyAFCR0JIE4ZEI5wZupg3J9+w1g
         2puXK0EcjlhWsi5GBhIpMEM9121LVw2XzSmkMtxjJRbbMndMzEf9vt/pghptrHwEdwE/
         redg==
X-Forwarded-Encrypted: i=1; AJvYcCVYvHWQAn5kybjNo0gyo2MRrhEqGPbzPuuA9jERjvoefrXe0NfVVxuBcmQ/B1QA3WzfRk3jBuDFcky3mPI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz7xzEQBLUf1H0Y0UhGUwXJqArAqiJcdbNZxhl4WjSwJqhWiOw
	jtbduPb9mqE76V4vHfwTf6dbdcEe6sT2FNXE8SXWxhzd1yckIY8bTNw2
X-Gm-Gg: ASbGnctUJP3Fk7e1JnrLhr18h2ydQbvSRidTjUZ3urewJcEt5Knr8owXwEZHa4tZwSg
	nJ/H6kIZmBOiOZeEqNnoJqdKhWRqPpOgTJMQFAGD/YF9Dxl8E2G84d4Le8STKdmE1bCFvDhFhpR
	q0TAs8U8KuqzzGqrum9AfS0shKdF2esZpSl6fqmgTx4BM5XatL70xyENLhB6h1ob/XlDYTPzkcX
	fa6YkCSVuf9kcwYxgfyR5TPZo6M2XfAe/5eZBa0p1Q1/vsibl74y0nsH2JKYpDapFXsQVajcQA4
	Wjh1XP2n17n3u2SApoXbZ2ZgD1P2OaN6Wl43Il14FsI4WqhZ+/Dk0VcaT5Pf9GI/3/Wc7YTzTSl
	8LqJFvfyXYYR43+kBOsgXGjRmoj+8WRbN3W9eSbTh7zvhKx4cs21VtjOKha3C6eeFOcyy61ryFi
	S0wQ==
X-Google-Smtp-Source: AGHT+IFBW+GwaEA2ubb2mwsp6bP8FgOsTGJI8y0RHPKChpcizObkmjhUhUQELiKNQOwlzESlTUwflA==
X-Received: by 2002:a17:907:2684:b0:afe:84ed:6152 with SMTP id a640c23a62f3a-b01d8c74be6mr1676804666b.12.1756910136713;
        Wed, 03 Sep 2025 07:35:36 -0700 (PDT)
Received: from MacBookAir (78-80-81-163.customers.tmcz.cz. [78.80.81.163])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b01af44a01fsm1076010366b.23.2025.09.03.07.35.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 03 Sep 2025 07:35:36 -0700 (PDT)
From: Aleksandr Shabelnikov <mistermidi@gmail.com>
To: o-takashi@sakamocchi.jp
Cc: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] firewire: core: bound traversal stack in read_config_rom()
Date: Wed,  3 Sep 2025 16:35:31 +0200
Message-ID: <20250903143533.21210-1-mistermidi@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250903134728.GA134568@workstation.local>
References: <20250903134728.GA134568@workstation.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Thank you kindly for your time and review. I think it’s an excellent idea to
add KUnit coverage, and I will definitely give it a try.

Best regards,
Aleksandr

