Return-Path: <linux-kernel+bounces-896342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0DAC50259
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 01:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 785374E59E8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 00:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26431D5160;
	Wed, 12 Nov 2025 00:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Ra/64PTl"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18512189F43
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 00:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762908448; cv=none; b=D1OKoS70f/qyZt0i4Ro9W8GB5/nzZYdHOO3ICdCF2SDqLoA1M014s8v6jOyNv7Gjc96c4CYwBlnzSfzi5be4uvoB09YcibPY7DOUu/SjN0YcHLu/lPjbJ4XeY1h5jfKiCVD1eupuYn++KqoJrPDg9+6FTQOGTMTVkngFARKsyX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762908448; c=relaxed/simple;
	bh=iLvULS57NLgM8eVmAKOp1ksCARhHnb96gbVXO9LaUNM=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=lzKzTC0kfKk3WNHXy0nXFpST+3nmf/w2JCLZ9M8JsVtMJn6gq04fPAZWGoz6An8NaclfObLmQUzlaKH7hu+Vatwn0Wl8ivEURjB+q97G0UKkr9Ucgc1RFvEZ1X9H5rv7rmsp/Qxv4N1y8/1P01HmL90DgOa07VyVFVyLs0JIqAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Ra/64PTl; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-882451b353fso1824946d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 16:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1762908444; x=1763513244; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QqSkWlqwkh0AdYudIk5TWzMK7MRj4h13Ekp2jfGvU6E=;
        b=Ra/64PTl0zqBMaAaH9AdgqxwMKD2a3yqucPVt/jeaghGKhtaSAAo6GLZ+kalMxzBqY
         rWGMWSEpncx/MxpL8SvHx8bHXOGEJdjUdngHAKuaqn1E8gXQ+PkKB5DFphPyXdnzieK1
         eqnq3CA99j94o68A5H/Qz/lZ1OMrZfaoIkMEX0vTguZv9hwtlH9rXbvvicdtujM7COJH
         8b5iAHM83uGVE5OOycqRq/J3gaYpVcI1iCjTl/DUW7z5kWFxazUZI1u1sZUddYuAsa8D
         R3ZmSjofPS3ksPjwi8+t6s+vEWwjt6Jjibj9C3Jh/pjmTN9DY7YIQTQdbthbEcCT9YmT
         y8aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762908444; x=1763513244;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QqSkWlqwkh0AdYudIk5TWzMK7MRj4h13Ekp2jfGvU6E=;
        b=vTA9yrhZyJ6oCf5Y6QYRJggY4TD9PAhQU85KjmM6ReCw33CkxVDV2NWPrSIYu2SVl/
         yUUuppd6sprKS3XnxGxnpnD3E2ybchetIzs+U/nGxB0s8qe3M3Ke/r0Hxhe+9VktoUI5
         PEPz+lAs/geWzOGLzsotF5rXGTaLwxXl8C7kDlTQlS66q2P2jU019mCGigCpYAroJy0m
         bikuuUakAcOVBqWjKxj65XoieFuQBYywJSp51WhcZozZU8JAPwaY5aMdRZVx5t78QNX9
         phOCZnwtAC8S+ov6O876eq4ebu1g8N1k3N2YjNrAnkUQL9YNy+rp18Q7dkyqx156Cp2z
         vJ/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXu3FOMcTwb9bbGbRypC2J578z51hvSUboaqb2m06Lod5HCIm4InlLGfq4bh3NJ6kg+2n12Rr2dHqs1Cco=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq7pDoHtnZbdg9PBx9laeqcRUMRZFU9MeUe7KnZrZkOm4I348Y
	RlWWh7f+w9ux16xpzCAqd83Gl4uegqku05FNp/ws3B+3WW9t8aiyTJBuj2GueLy9/g==
X-Gm-Gg: ASbGncufvAJBu24l9sArn8SCpcKUKzA58dzMsYJcm4gJjv3UdEsX12Y5ZwjGdg/HOvZ
	yd/MDPMW/vnx58B9nLOQ/upLz9e1ylmzJRwWZKqQY5IqJ23cw6jk3ILFvXpJJgkaPklnpj2l9zB
	O17VesqCKQPYR7bcMJaWeS88vF8MFS7kHWz1kKGef/sGB3apI7orDdcA1fQOUCU/abskQighIRA
	/Mj5nJUOLtJ/xhbRFdS96vtoY38xRcfIncTGqjbMa90CGe3hg/LimzuOzg81rCZe1DGmEPpOS6p
	tbXFe5Rc7Bovo4wnf+anArMK95dCTUTC5hXBtv6xE377eeanQJNNUdFhi/lOaUEDLI3TNzlnu6k
	MJgni1yTbM9gkaeiPFIEG3Y2Hc+eE5ilnP/vW3DZ5Ij2sOdJmp5oVTkK4VvOMt1/zw5T9KCdHuV
	W0oRE07nzD7+qFog1i2857ykS/mcIOGhuJUOIiQOSqsC6PBA==
X-Google-Smtp-Source: AGHT+IHF/PZ23l/xxiHoSeZZOtkJgamDuq/rxrjwGQfnK4SCJtFUaCpU0O+jIq/yckwppaM+qeH7Ww==
X-Received: by 2002:a05:6214:2524:b0:882:4dec:42b9 with SMTP id 6a1803df08f44-88271915d0amr17580886d6.26.1762908443800;
        Tue, 11 Nov 2025 16:47:23 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4eda5956968sm76906581cf.6.2025.11.11.16.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 16:47:22 -0800 (PST)
Date: Tue, 11 Nov 2025 19:47:22 -0500
Message-ID: <fefdd59acae4d7430992b390b6f9bdfc@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20251111_1943/pstg-lib:20251111_1938/pstg-pwork:20251111_1943
From: Paul Moore <paul@paul-moore.com>
To: Thorsten Blum <thorsten.blum@linux.dev>, David Laight <david.laight.linux@gmail.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] device_cgroup: Refactor devcgroup_seq_show to use  seq_put* helpers
References: <20251031213915.211046-1-thorsten.blum@linux.dev>
In-Reply-To: <20251031213915.211046-1-thorsten.blum@linux.dev>

On Oct 31, 2025 Thorsten Blum <thorsten.blum@linux.dev> wrote:
> 
> Replace set_access(), set_majmin(), and type_to_char() with new helpers
> seq_putaccess(), seq_puttype(), and seq_putversion() that write directly
> to 'seq_file'.
> 
> Simplify devcgroup_seq_show() by hard-coding "a *:* rwm", and use the
> new seq_put* helper functions to list the exceptions otherwise.
> 
> This allows us to remove the intermediate string buffers while
> maintaining the same functionality, including wildcard handling.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> Acked-by: Serge Hallyn <serge@hallyn.com>
> ---
> Changes in v2:
> - Add setq_put* helpers to modify seq_file directly (David)
> - Update patch subject and description
> - Link to v1: https://lore.kernel.org/lkml/20251031110647.102728-2-thorsten.blum@linux.dev/
> ---
>  security/device_cgroup.c | 56 ++++++++++++++++++----------------------
>  1 file changed, 25 insertions(+), 31 deletions(-)

Looks good to me, merged into lsm/dev, thanks!

--
paul-moore.com

