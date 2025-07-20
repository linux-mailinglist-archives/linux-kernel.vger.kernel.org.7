Return-Path: <linux-kernel+bounces-738378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C99B0B7AB
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 20:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C9B41781B7
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 18:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2514B2135AC;
	Sun, 20 Jul 2025 18:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="a3bHi0dk"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DFE195
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 18:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753036420; cv=none; b=XvPrc9Q9ibgijvttBRkoH/v4BkPqxWa8p0JFHTHWQU6gTx4uz8BnFTawA4gGQb2uTr3QSdcGUPfTS8yczwFTpDXHl9aM9BxpCv8/cfMc17nPGEJRUqzLghi/7r5rkuzwQB2i//fgfsl+ZxhDGegELAkWKVhT66xGbZONhbElcLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753036420; c=relaxed/simple;
	bh=PqJuB6BTnlUL05uv8nlQVPJ/J+B6nFinOKNvYsNcWoY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hCFCv5KTP5Hf2ZqxHB3AQ0+B6AuMVqpN6edWPfMB3nyYFt9h8eNZMlCs8a+y4lTDg6Ay5StSAgQXixWtujocXuk+jtfcOzFSrVXvfyiWdyKaNkNHOeab1/QZf8TKfOp9Zi097kVtOlGSfJbT+Tk24TGW5qx7h5t2JMFY+x6lvvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=a3bHi0dk; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2352400344aso32141595ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 11:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1753036418; x=1753641218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J0AjEJVnMbl4XQ0rLjJcaPI92XEnzLpKwxDrSH3dYbk=;
        b=a3bHi0dk7z9FbvcZh2xMIPvB5T9Jow0Nb/eorlAo3ZlQl752oeKVLuRHb6DSEQVPTc
         Q3VTXCJi5w+ZoHh8BumdegQ0PYQF35sMTVGTrV5uH5lvB7nmLpYwWK3YnTVpCT6zMCj0
         +KCZ8KWcRjpKEiMCDViM7uaw2N3xPHKUk0S5JXY4+3Vkmt298NlC9wKpgr+oOjQ9cE6C
         hfxjZ717d1by8YtZerepkZL3Btmkl8ez6ialsh9L/0CnbxndMwLzAPxtOmdozLlKue3e
         idzfB84Adx+OIUXTe9vUXjmgXO4jUkipayb1886ZcF+Ltb3Mj7fSvwAGZxoRH1JLZng0
         wpkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753036418; x=1753641218;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J0AjEJVnMbl4XQ0rLjJcaPI92XEnzLpKwxDrSH3dYbk=;
        b=GjpPmbs3FSaCmPfmCfwXM45scKWB2QiaUuxLMAZSh64WBUsKIUEiMOyJIVhtVMK5Lu
         4I+/5YUDCXdU/Xot7dQazZAoCQJQhkkF6sPPBjSQmaDBoIyPwY7tD/ycKMtW6e7cOEcn
         CQf2se7Yjg8MvVHxY9ORa1BwLRff7A9xfnXyv+NZKqlmdQd668avUWEKbs3Ikeor7RIt
         GmqZfkqCjDBR+8JBIXLCynZyy12pqsx7BXBA7qX40MZP8imjd+owJs4VCCamxFmpg2iu
         DJgDc/t9Swh2hxd8tPi/d1ZaLKXd2UvXjjF07F27pOGT4IcKJ2OXqNDBRI/32vM8n9TD
         CiRA==
X-Gm-Message-State: AOJu0YzwjL/qOd495EapM44S+AiK05rUQSgBBnfDbTr4zSQ/iuzS4pZS
	Q6aSj5S64GRlRHSKhTYp7wvuWIon9DuWC+bZFQwxfb1ML6iBus2OptWyXrAnYOwfjUQ=
X-Gm-Gg: ASbGncsN0IuMOLoKNLvHEKAzdlLPW2v2X+L97nXgLlLCalTwl+pcoA2hXTQ2jOd0F0h
	tLY0HYDy2Fx7HUrq7s93nb/PxCPhe1rHYz1wq3m3di1UtKVWhB0vZEAxya65qcXwvZf4ITv+hMj
	9R3IyxfGOi25wBHkowHAH8R8He/lfp1HD0trnHkKtklTcfMK1d59wtC+hG5Zrt8F/xHHvAGYCrr
	p416lDSbyIkccHq0e3gYQx9CftU6KnNNKNoy1ieLMpBdr7YwdoqE67xlYrz8ux3+2ZICuVAT4nP
	QferB9hM1YxUjs95Etgyi/LuYqlN1NRZDEm2bLswieUSKHq0P77+4HOC6ZPqRiPIbDeJG0vN2js
	oHfjyemKDPF5EbOLY
X-Google-Smtp-Source: AGHT+IGQfg5BtWVOsg/XbnN9HxpcleMGwWsuvZ8KzthORtKDs0VSV7ilzMvJ1+Jl8WSVxY65b3tdxQ==
X-Received: by 2002:a17:903:2290:b0:234:a139:1210 with SMTP id d9443c01a7336-23e250012ccmr288632585ad.53.1753036417891;
        Sun, 20 Jul 2025 11:33:37 -0700 (PDT)
Received: from [127.0.0.1] ([12.129.159.196])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6b4e79sm44205515ad.105.2025.07.20.11.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 11:33:36 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Masahiro Yamada <masahiroy@kernel.org>, io-uring@vger.kernel.org
In-Reply-To: <20250720010456.2945344-1-rdunlap@infradead.org>
References: <20250720010456.2945344-1-rdunlap@infradead.org>
Subject: Re: [PATCH] io_uring: fix breakage in EXPERT menu
Message-Id: <175303641666.493216.2544644366989579120.b4-ty@kernel.dk>
Date: Sun, 20 Jul 2025 12:33:36 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Sat, 19 Jul 2025 18:04:56 -0700, Randy Dunlap wrote:
> Add a dependency for IO_URING for the GCOV_PROFILE_URING symbol.
> 
> Without this patch the EXPERT config menu ends with
> "Enable IO uring support" and the menu prompts for
> GCOV_PROFILE_URING and IO_URING_MOCK_FILE are not subordinate to it.
> This causes all of the EXPERT Kconfig options that follow
> GCOV_PROFILE_URING to be display in the "upper" menu (General setup),
> just following the EXPERT menu.
> 
> [...]

Applied, thanks!

[1/1] io_uring: fix breakage in EXPERT menu
      commit: d1fbe1ebf4a12cabd7945335d5e47718cb2bef99

Best regards,
-- 
Jens Axboe




