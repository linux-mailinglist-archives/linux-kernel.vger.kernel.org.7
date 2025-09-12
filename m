Return-Path: <linux-kernel+bounces-813938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D53B54D49
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12D94A0152D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE05327A1E;
	Fri, 12 Sep 2025 12:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WsYaVhjQ"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71CE324B1B
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 12:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757678936; cv=none; b=dNlLhROI+6hNFIV67CErHFvS4IyTRN88raCGSopdIvoMiNFe+BxO48L+HUSu8XcnAuwxkwTalhmkebMcKf+haIfA4+4VZ1rxDXJPUe6Qs+jLkyY031KNt7XAUeHURhQfck/HuHVxKd7Nkz09XQsFjz6E1qtfWN68aY1x+4YmZKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757678936; c=relaxed/simple;
	bh=Wz4E5peEWJEuLH5HpKzn2maiOPcV7d/t/JntClDMc3Y=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=gPQ8HtR0ZW6oQpxB9dOpXfym70C0ZWTNeGei0RI5ffmhTwozL9qnoRphtYraXq+1U2VEUNmWL/jXz/xBAmfaniQ3M8QbYJtqRHnOTULSjFHIl4aJdFiMayrjP8ncSJth1YY8gRRP/XD6Wz3vzUhWlLlGxwt+l8echzJrKtFuftE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WsYaVhjQ; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45dfb8e986aso19164005e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 05:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757678933; x=1758283733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Wz4E5peEWJEuLH5HpKzn2maiOPcV7d/t/JntClDMc3Y=;
        b=WsYaVhjQn2JqKOoWVPSN3hvIwjd0D7IZWiGO4L4yFLbMk/ocRhAfR+M1tcvbeiXIe2
         LB2VMBqAyNaKlV33VR9TlZnlKbOZGT088PYnXiLVebdx2M/khLD+oYqScZQgSq8jMOwk
         JVeOS1sf52TKhpVshHayo436Z9lo5dxkZkxw3Iip8ayWuU/xKH49sUvEbkGpwC4sflaY
         O/w0b8vAGiBImtanSV1xlRWMmvMqzmRntkYpu3AsRf0l/2JQucBPqV9sxhFuKay4eJaQ
         cav0gQEn3pUvJGtkdGuw3DkwZUY3dfMQ+bsJVAT09ssZ3vklqDGZk4RjOcDkcG/IycEf
         04Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757678933; x=1758283733;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wz4E5peEWJEuLH5HpKzn2maiOPcV7d/t/JntClDMc3Y=;
        b=dxlwAaszZr8nnANSR+yDgQ5zBszQBdhyrYCNcksPdfo0Upewg+WzsPgoRxn2y+JRgs
         Y39fi/cQg8MG3mHukO+iWz6iyzFg7pBIekbWrq8CqF+KQfWAhWUwVw0oOv4Q64V41iW2
         L3AqHPjEjqHFlyGReZ+A63Dzlqa3x8dCddSCeKDHDSlbRWSEN54bElURHebdZTrm+KiW
         nG1x0nD8/BL0t2gKaTSe/mEkUOIrH/NrXsu/0CWyijsnuSdZ9+A6qobNWOkaZgMcUXrT
         pvyD4nRnvEyvJrO9G6KEg8fkoEmNQfmi1HtfmoEVFguVfp5AUssgr/VIJz2hsKEyDl7y
         Xw0g==
X-Forwarded-Encrypted: i=1; AJvYcCWmzuwM8xD0ICwlPnmWz7hs5UQLCbkZqhU8VlHHOFQIlbHqCTU+5FRsaFnC/CgmuMaRe543KaYJj5+z0Ng=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ/ZAwQcz/tIR0RT2yzV4SfldGMaqsed/Wj8bUT3dxKqoouQUF
	Vnv1Dhlfyn88Sie5fwBNZ4bX6RzErXJRzgBJSCrIvcyc8cLP40fXJXZml9g44Q==
X-Gm-Gg: ASbGncvRMfhJUP0N7xZ85ktDW5ZXuUoQtIb9GBfw3IV7H8DF3oSIyPSUdbfvU1yenKj
	cnJb/zkcrbMbavTDPkFdnHOPwfrWsG9Hqj6TibsMW/3whaMjmyv24GveJQ5md/SekTnBLZ64Ssc
	o2OpxElu3fa4JXf3n6P0cme+DBeJBG0pbQ6Pd2aT/2sU8SlwDRLt38J3/Viwkksl6SN03ncePWJ
	tFjrcmBLReVMNHBjjJ0+HxKFr8UuxoQZJereURoII/o+JSdt22GUFPgzK9JgDSrX2R46QQB3ffv
	n/qv7+GglHivEqfgaTFC7LJInm418Doak55QHaHpEKOvPG2aWaefhBwYY+pPoxwDoZJ1xI2Dx1H
	ohey+DgnUT0byDK3UK76QkADD52femu13l3qrSph1oCh1
X-Google-Smtp-Source: AGHT+IFBSzBHrD878oYYF5kKGavS67qgNolUi5Ck7EzGdSc891Ykev73AV+0ueAWDKAT71qdNTJHOA==
X-Received: by 2002:a05:600c:1d2a:b0:45b:9c93:d21d with SMTP id 5b1f17b1804b1-45f24ef20d0mr11997575e9.8.1757678932165;
        Fri, 12 Sep 2025 05:08:52 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:18f9:fa9:c12a:ac60])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e017b2722sm33750515e9.1.2025.09.12.05.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 05:08:51 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: =?utf-8?Q?Asbj=C3=B8rn?= Sloth =?utf-8?Q?T=C3=B8nnesen?=
 <ast@fiberby.net>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,  "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Simon
 Horman <horms@kernel.org>,  Jacob Keller <jacob.e.keller@intel.com>,
  Sabrina Dubroca <sd@queasysnail.net>,  wireguard@lists.zx2c4.com,
  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 07/13] tools: ynl-gen: avoid repetitive
 variables definitions
In-Reply-To: <20250911200508.79341-8-ast@fiberby.net>
Date: Fri, 12 Sep 2025 12:30:32 +0100
Message-ID: <m21pobvrfr.fsf@gmail.com>
References: <20250911200508.79341-1-ast@fiberby.net>
	<20250911200508.79341-8-ast@fiberby.net>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Asbj=C3=B8rn Sloth T=C3=B8nnesen <ast@fiberby.net> writes:

> In the generated attribute parsing code, avoid repetitively
> defining the same variables over and over again, local to
> the conditional block for each attribute.
>
> This patch consolidates the definitions of local variables
> for attribute parsing, so that they are defined at the
> function level, and re-used across attributes, thus making
> the generated code read more natural.
>
> If attributes defines identical local_vars, then they will
> be deduplicated, attributes are assumed to only use their
> local variables transiently.
>
> ...
>
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Asbj=C3=B8rn Sloth T=C3=B8nnesen <ast@fiberby.net>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

