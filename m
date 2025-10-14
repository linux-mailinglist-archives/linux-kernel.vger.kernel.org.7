Return-Path: <linux-kernel+bounces-852825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32ECDBDA01E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 16:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D8163E5FE6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 14:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1692A2BE029;
	Tue, 14 Oct 2025 14:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8rUVAsv"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41DC188713
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 14:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760452316; cv=none; b=KGV6Y3s4C0cT5gLw0Fqmeqn1mAf8vTokzolGVcOffS4o8o336k6jyawYr/LeRirMgqorcHs8yIudohbAY1j7ZL7ewvs4tFKJp8UfmbhUhKVcu1i+1dsfXocfNYTSuDVU1ynMEGR0xF4gBphQBuV53gFFn4isOjXbL3j4bo7j35w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760452316; c=relaxed/simple;
	bh=6LNc+vdwep4BeLENBR9hSs9PbKUdEngRnpluAWS4E1Y=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Ao/YhKSak2bySi9cBTkQRzRe+dGEYTw4V5zNnmK5vsb+DqDlPZhxlzf2LNr42XlVQ5fzoF21nfsE/gYqTcW+FuI315ubvcRycVLf7mVJMgRmcqxaAl9fk4PiXkMEVUI/O+lhH6k75b9ojmG77/ZJq29nMPYvCL9bs7O0w9GqaFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k8rUVAsv; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-87bf3d1e7faso20740126d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 07:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760452314; x=1761057114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/p61iaYEVvkcgojxCMrhZrvkUbphBlulNRGVFmSL1YY=;
        b=k8rUVAsvTfBEyERHFc2Wo7Pf0nSM7acG6HfqjLNm8QoPC5/yhxR34pd/fZzoGSh6DW
         7CzUmmamkVAjRp9cB5WVaYZO56jsv/6LEzLb1fX/vtOv89KwvDs8iWQSXZrtVj8RCVvQ
         qJ5yCETx9wvGPMXMCzsGMu6bcf+YgBZDEMtfQfLu6KyrXpu2ThdCBNAE0w0YID+/1dX/
         Rwp7+U5JeIozpcs9pEK6PlB/5gR6pjQpTH5yeArA2ZaEtuCi4iJjT7UdjqZvJdC8D3hk
         rtZaByVhIBrD010vY1rTKy7e5i/60UofCGK/QJCCqVmsmvPuvTfIf8f0hXK/Tdf2HM3H
         9Kuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760452314; x=1761057114;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/p61iaYEVvkcgojxCMrhZrvkUbphBlulNRGVFmSL1YY=;
        b=absoQhQtcAFxIOh9HpYu6v0Q2XfJwX7zf6kb/IaV28l+GQog8DltQQNZqSqmIy5bao
         N5cDU5lLe+TJqaujRPh0XabZ9mfxov4ICKy17D6qPO+w8EbIsjlEQfJJRfVluvQAVcmn
         TrwjvYo/Twz9khOsocUIAx2WKTOGHSWqi44QM9x3Z5/kbwzRm2fIl3ixHUXn9rb4nKId
         cHtjgdTagtr4gIRmMokzcZH9zA75FEMsqsAiVBNbcUEJjBOs8bndKrL5SnQATPC50YZo
         bD83vtvo04QkL0vlEtScYspsCK4YC7sfbL9XorIbbx5P0NH1jsF+6RxxoewyJ9WkDgfy
         DQkA==
X-Forwarded-Encrypted: i=1; AJvYcCXspmkOJhyvM7Tcxbm3m8kF7eo1SP975qEh0srk1Z9UJujKvwf9NL/mmDgto5K8SxZps7FLh4xSM+ZSRnU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ4edi2NVQ+SSUNYOrMo1B/s+a6hNa5QoP2FO9ZmZQ/jYGDRYe
	l1JxG9cAxHIgeU0kSLA1AOEB3Z+F/A3e77p62c/djcpNI5urNKRugr2i
X-Gm-Gg: ASbGncu6Oj2VBMtmpJl5dLCzKqN4wzp7u+5ibVL3c/fzMpxJD/ncGJmu0ac/z0R3THG
	55YUTlindaQ6c3wb2GclC9wUoHHKS8CwhThB5rxeB0esszj8dl8t3FPsY5Gp6i/E7ye9R7BrxWR
	ImArDwuW7Gxq4HorjCMWj0h4y9GKXnMS7dIFDyoDPW5fArGb+rgYnfaIXgAKk3kR42NB94+3tnC
	Qc/910LQZ9TCWdTc4zn3hdI1dPKzEUimLex/f9GJR+jyp1fWHeg+fm4WsS19a3x3uM23JPWyXyC
	QzzSzo/0e1xrH4xu7W/kg0uhi0Nhin7cXuTOQcUJaoydN2bExNRd6+bNcecJ/1cLPV92oAbTbQi
	NHxuUzBeeBEqj2oMJM4tPT/yTGyw3uga7tqH25crbdgFFH3c4AXhFL6oUfutIiTN4zoqK0xCJQW
	z76u3N2QDRMv9bgUzhv4GFQzo=
X-Google-Smtp-Source: AGHT+IGwNwmXjeWv8Nmp6mkj0A5dZpoUF8uBRl0oD8iLD5gvHZaccJu0fCjSAdWukmLgkyib7kmZUA==
X-Received: by 2002:a0c:d785:0:b0:87b:b675:c07e with SMTP id 6a1803df08f44-87bb675c178mr190769806d6.64.1760452313618;
        Tue, 14 Oct 2025 07:31:53 -0700 (PDT)
Received: from gmail.com (21.33.48.34.bc.googleusercontent.com. [34.48.33.21])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-87bc3570c11sm92598796d6.31.2025.10.14.07.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 07:31:52 -0700 (PDT)
Date: Tue, 14 Oct 2025 10:31:52 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Harshitha Ramamurthy <hramamurthy@google.com>, 
 netdev@vger.kernel.org
Cc: joshwash@google.com, 
 hramamurthy@google.com, 
 andrew+netdev@lunn.ch, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 willemb@google.com, 
 pkaligineedi@google.com, 
 jfraker@google.com, 
 ziweixiao@google.com, 
 thostet@google.com, 
 linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
Message-ID: <willemdebruijn.kernel.18f9d84fb2f05@gmail.com>
In-Reply-To: <20251014004740.2775957-1-hramamurthy@google.com>
References: <20251014004740.2775957-1-hramamurthy@google.com>
Subject: Re: [PATCH net] gve: Check valid ts bit on RX descriptor before hw
 timestamping
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Harshitha Ramamurthy wrote:
> From: Tim Hostetler <thostet@google.com>
> 
> The device returns a valid bit in the LSB of the low timestamp byte in
> the completion descriptor that the driver should check before
> setting the SKB's hardware timestamp. If the timestamp is not valid, do not

nit: weird line wrap. if setting had been on the line above, no line over 70.

> hardware timestamp the SKB.
> 
> Cc: stable@vger.kernel.org
> Fixes: b2c7aeb49056 ("gve: Implement ndo_hwtstamp_get/set for RX timestamping")
> Reviewed-by: Joshua Washington <joshwash@google.com>
> Signed-off-by: Tim Hostetler <thostet@google.com>
> Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

