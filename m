Return-Path: <linux-kernel+bounces-863039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC82BF6D8E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 257811887C1B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB003370F5;
	Tue, 21 Oct 2025 13:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qco9XJSn"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD17517A303
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 13:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761054145; cv=none; b=htBC2XRfpV4vTwVCdK2fLszNMvnnEA4tI3SgM75zuyszYqCb2WlhxRiQOACF2Cy4reUpS15NFSF0GpGPkSHBwCU2yCBEwMH3RrrP3taTSU7Id+eh8LknaV+NNLUQiRmAaXZceRSCVxj+vrO/y8f8y3Pt7eUmZGCj3vjzJzTEPO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761054145; c=relaxed/simple;
	bh=bxHGLz+xlJewzMmRFIuIR23gQThD28fVSG7QUjGyY9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CsZwkDdO2f1jvrvDOhlLUkfq8HPX73ScDwSuJuJqw+51NlPxrd6JiRcyNz5FvBbcPafLNfwKODnd0UopcJbJRMzWN/TtKnuz86KGKsJTMnVz/1yaHajD0qmGY9yZVr40h0aoBHZ1P2jySaEfjTiJ5gu1vF1fU/d05mWeJrjJxhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qco9XJSn; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-782e93932ffso4811679b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 06:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761054143; x=1761658943; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wgZPMxLu6X9wz+t1vCeUGO6rtKpKjgYYhFE+lvxINzo=;
        b=Qco9XJSn8o7aI7jdnej999Q66H4OF/VjuIKBTfCudYuafg1UVi1nseppeUfwH4ea1d
         Z2PPyBMozXJYzWqvNU4l0rULNb3p/5uCHR8Gp3vMbB3bcbFIwEzh3i1uen4r5Yp6lNC1
         n6F2gLb5kBy2K69Td+Y/5YJhsMX3JXhlTmmwMP3q3jd0Qz3MqMwLc9O+G5zm9P2FHRpZ
         +BuQSYEQeGs4VZb32Xu7d5yDMlSpQ8CQ+iTaQ2d3xkjToyqRtCJrELpHl0CFNImyY+Lg
         o49fjDhsO9Deed8OOfsouuVjvq2JnrijkquNucDx5HGx1gSUGPQ+c1KiRCGkR+c5F81x
         RcyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761054143; x=1761658943;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wgZPMxLu6X9wz+t1vCeUGO6rtKpKjgYYhFE+lvxINzo=;
        b=s4+5H6E/KEdL9DOkUlapZWq50su5W/bO812aXWeCiqFZ8htic/FjDGT8lS9EmUdQkW
         2x8qZFzAUccVRWXPWH74NIx8wid1piqRNXV56j78SP0qG0o6wHuCPcWV4gGME/sLrgQf
         Y7Z9Ool5Y5mOqvCv/pfsH6y3isBXCWzeewtnY1ou5tlBy4tlg9lDdJGZOxdVqEH6aV4E
         FELGRUJEj27k2ZEw+iZYpi9gUFXY5QFIVhMJnG0+oOEX7Zphg3KNbw5S2DUvZXg4IOuE
         H/YGIwg5PucT6p5p5lbZYE5JvB6/rtFtrHVxwXbLF2iHGa0Bk554VN8ns9/UBAkz/uQb
         a4tA==
X-Forwarded-Encrypted: i=1; AJvYcCXuw2zQGh7FP+xk9bJtm0H6FC21kFQd2TLj3eCMCCeVsX4QTJ7UoPv+EAreqW4i+DIWIUhHkCarid7mGa0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxACissfhDAjOrmvBvtN+lk1/8NAJxYgwNNa0yPXmwCoSiSspKS
	9JEZM+t/VreO9IY2SQ1bHDERURr0nf0mMez852TV+2UZyC7rmMKRkg9p
X-Gm-Gg: ASbGncuE4KuQyKqomuWYekDBFpRnDIS9Yw5tyqjZVsn+OUMmPHJuaaa9pLl4FGQjJFC
	hhc/wfZ0Z4Z/Haat8eITbbyB4F4+A01WVFhNwzvnHSthksh7/6izfAC6GR4h9d3N/uU51PPqwqR
	NZ7thl6vKRVJ06Iqk8ejd8RrP78MTJ5xctmxju/noXhF4nHSVXUlA60ENMMlOTSXtb4VhzilbS/
	96Cpx3uqwJ2kG7lNexpqKedDFRmdC8aZN8ger7idWGJs+qtGcsrfjIWtoEBKZEPkqDevBD0J9l3
	OPtmU2rNe7xu41stYE8DBkMEZG4XHe3Ye1lNsGyNWUFRKjONKVWlU4jfMJ2zMlhY1WxDmNK+MJe
	WBBF2nMGdsO+GvBr9qS1z75kQpJS8sEh75gpsi9C5NG8B+K7/Dqs2WLeE1Agz6PV+obVXFdmLO5
	iHAIXf8Yvba+do5TLzjulot7+XbwLQ
X-Google-Smtp-Source: AGHT+IEtBrPuQQUxw2bft59BW11T/7eOEgF3RMVKZ3jPGBy5mT6+NnW6S4WaVnFWlQfeAnAVDZwRzA==
X-Received: by 2002:a05:6a21:6daa:b0:32d:b924:ed87 with SMTP id adf61e73a8af0-334a854ac50mr21383426637.20.1761054142909;
        Tue, 21 Oct 2025 06:42:22 -0700 (PDT)
Received: from t14s.localdomain ([2804:29b8:508a:1537:573a:39d:6287:7ddf])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a23010e211sm11306341b3a.62.2025.10.21.06.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 06:42:22 -0700 (PDT)
Received: by t14s.localdomain (Postfix, from userid 1000)
	id 60D4711CF92D; Tue, 21 Oct 2025 10:42:19 -0300 (-03)
Date: Tue, 21 Oct 2025 10:42:19 -0300
From: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To: Alexey Simakov <bigalex934@gmail.com>
Cc: Xin Long <lucien.xin@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH v2 net] sctp: avoid NULL dereference when chunk data
 buffer is missing
Message-ID: <aPeNu7-COwBQS21U@t14s.localdomain>
References: <20251021130034.6333-1-bigalex934@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021130034.6333-1-bigalex934@gmail.com>

On Tue, Oct 21, 2025 at 04:00:36PM +0300, Alexey Simakov wrote:
> chunk->skb pointer is dereferenced in the if-block where it's supposed
> to be NULL only.
> 
> chunk->skb can only be NULL if chunk->head_skb is not. Check for frag_list
> instead and do it just before replacing chunk->skb. We're sure that
> otherwise chunk->skb is non-NULL because of outer if() condition.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 90017accff61 ("sctp: Add GSO support")
> Signed-off-by: Alexey Simakov <bigalex934@gmail.com>

Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>

Thx.

