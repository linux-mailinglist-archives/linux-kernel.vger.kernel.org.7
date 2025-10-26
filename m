Return-Path: <linux-kernel+bounces-870312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D81DC0A700
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 13:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10E7C189F895
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 12:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1AC2258EC8;
	Sun, 26 Oct 2025 12:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mpI7gZPH"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831691DC1AB
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 12:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761481680; cv=none; b=EDCXSNukARTaQQbSD2nnHiuI7NG/7QN2nTtOCsCrZ8vPv/SPapsYMKtK83lpeI1caAbBLqSrExcp5Yc6VVAMhsnsUJXiyPxco0M/FkYP9NGKlpPyN7y+YkkCta1yAz1IQcbK1JzwyXx2Wa1Uy/jf+AS+hhz65TlwKEIPfttheWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761481680; c=relaxed/simple;
	bh=96xgEF/cDhtXAWfkTUNwDGMDjcisf5kN8St/i2PJMdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UZ0geP1tKNRPnk3uCiXD8fZBLgBJ8IGnZ4Spp41wcXzX2zxxqZjW1J5cpudNvCn3+km1Yq1v+E9RX3/WYFv0BzaksTMBrbQ88cCwUqzKBG4HhdexBzj2hqmJihFhDc2pRzWKbcF/taNI8IkLOFu9DbKFMO5M5KN4evS7sZSvQ14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mpI7gZPH; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-61feb87fe26so6480512a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 05:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761481677; x=1762086477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EIyo2FXSI9SPMUW3EpKSAUcsK0v7MMc631sMa+neJaU=;
        b=mpI7gZPHdQ8TTyod60+eGIxcs/iWH3jWkmzTxX+jc8uNfd6EBHLpnWAH6Y6CeStdPH
         Fn5IVLPB7bQ2JbUn3kqErMQDlzAh/WAtSdYqOmqQWrG9LPitlSmghihc/KnVs9f1CKjH
         9kW8q7rgcAUhGxGixlfKPorsP0dWOzZw3pEy45tyYZW5r8HrfvUpp5u976f42RlQEp+o
         3x8sVDD/E5m5sGGuQL91ozMQ+MnYMc8pwkyhntxRk/wTc9LaBM3EsyMieHN5oYnOFGkh
         G+2iDdYQG58kgaE+bd/HRL97opcdxSbkW4qRFXUpPgXoS3mtdtj7RTpy7VIs8UyqzbIH
         oyuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761481677; x=1762086477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EIyo2FXSI9SPMUW3EpKSAUcsK0v7MMc631sMa+neJaU=;
        b=fuQcdZFThtm4ryttbZc98WuJtCoPBzbMMYtedYIBGGowjD4IZPM4nPLva53W6IXFOE
         j+hucHCNB9F/LnUFAcvbRScpzS0lwizuj3RD1TPjqblCyatY5jjHugTq0TPQyO2LfIa+
         NkDxwpd1F128VYnPVONpkw5KP38BZ0rLji4GbcrJbjhI6jAXVqC57ZGCW/P5jXz6lLA8
         sEqVEAh40HwasNQUM0XKB3ext41/RoFHR2J8Di2vb58h428tx+L9qJNfUir6iIw/A82G
         DevXv7lfiWvxEgpwMxV04Paoh9ibOTy42kuKhQ/TYGMCbgxKM8z66cxIBsnUW+nR8cBj
         nddg==
X-Forwarded-Encrypted: i=1; AJvYcCU4DyBQ5lnvQ57AA6jntP5uO9NWZ4jW1xGFuk9MqJ5hVR5Yp3GW9Y70oypSudoFxRKI7/6t52RRVE0Fb/U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5xQ4/IeFhq9bbTTEgy4ia0XVyin4GEcZJzCMCHdhzw1JmB7hK
	Lev4mXJBmfZ7ChDQfYS6tpklm03nDEyryq2KxYCv2RADl8ItEqXhD1Bv
X-Gm-Gg: ASbGncvzJTWTkXGXgHFyjR3T8M7RS9jKk3uDfwsayxZ0+0MQ1Hkb/gGU02UQq2/uWkc
	hY1vFkxJbKJV6wv54eXyk9Pg0Hsti/tfANBfZL0pi7ehTNlnHM5OIwM+0g/1Yjl+4jF8ufjg4T4
	X+jY4wtz7bxZqfsLnI8QwFDJ6gM8+H2466Vbj7Ml4Oc5Zmgd2a6VTJXdtm1uBqiNsPhdn2vQIot
	JXORkNnglqfGOC5gr75jXOrcFiuVX3r4Ph8UasOeoGuNdNEETc/vklXtuHf08OlzPlsPxsGza60
	ejAAq3JBXDXOYesZ0LPT2ijE7Z6oRrAUjPxOlMYDGlfuYKvy96aBTcqZe9dsApsghM0xkFNYwug
	GsnFyDBFxZRGYxmGC2VaV5P8WJy6xI8aGdHlf6CMnn68vwaTYHXcqBuKNfUMCWgOeYh/LV4toQS
	8Tml3FU59S3HGE16N84E1wgw==
X-Google-Smtp-Source: AGHT+IG+nghLDB0dKUqOb9CoFdpZ3LvT3sjNG3elsEcJPMQmBpgpXzecd9vKXOr4yry1R2RtnfT9gg==
X-Received: by 2002:a05:6402:430e:b0:63c:b2:c656 with SMTP id 4fb4d7f45d1cf-63e6000378amr6445996a12.4.1761481676685;
        Sun, 26 Oct 2025 05:27:56 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-63e7ef6c13fsm3796082a12.7.2025.10.26.05.27.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Oct 2025 05:27:56 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: alx@kernel.org
Cc: brauner@kernel.org,
	cyphar@cyphar.com,
	dhowells@redhat.com,
	g.branden.robinson@gmail.com,
	jack@suse.cz,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-man@vger.kernel.org,
	mtk.manpages@gmail.com,
	safinaskar@zohomail.com,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH v5 0/8] man2: document "new" mount API
Date: Sun, 26 Oct 2025 15:27:42 +0300
Message-ID: <20251026122742.960661-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <hk5kr2fbrpalyggobuz3zpqeekzqv7qlhfh6sjfifb6p5n5bjs@gjowkgi776ey>
References: <hk5kr2fbrpalyggobuz3zpqeekzqv7qlhfh6sjfifb6p5n5bjs@gjowkgi776ey>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Alejandro Colomar <alx@kernel.org>:
> The full patch set has been merged now.  I've done a merge commit where

Alejandro, I still don't see manpages for "new" mount API here:
https://man7.org/linux/man-pages/dir_section_2.html

Please, publish.

-- 
Askar Safin

