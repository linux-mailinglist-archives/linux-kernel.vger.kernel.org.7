Return-Path: <linux-kernel+bounces-834105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6D4BA3E09
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 15:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D08A3B1961
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 13:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74FB2F5316;
	Fri, 26 Sep 2025 13:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YmaFyvNY"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C617513D539
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 13:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758893132; cv=none; b=lBnE8/9iI4euHY27oQq4J3lLroTZVid3WnKhD2jX+VbSxyjbgPOYRgRfY6F402wCrURydxsakUi90dxI84E1ycdQ8XKp/F6HIu8mN4vkiAQNZ5FsksN2263s2iiwevZrOQNqchEeOGk+Z8x+/Vw/ed2Utwg02L36+C9bRJwAslc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758893132; c=relaxed/simple;
	bh=AMYuZ0sc5IDgH+SwisvZgTm8JNt3MSUUKvWEXAE4oEc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GOGKrA4rYHy/MWFmjZGgnfh12mq2ZNyhREQJzvSstwJRwHm7WiWClOJyC6t2ULGhP4LbwjZuT/PZndAtjzJ+rSeBB2TtQDekMjK4XuDiYghqMj2DCFV9sQ2l2mKIqQfSnekByYV+hDG+SHqSLKLceQePlJgPLPSeY2RZPlGeT78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YmaFyvNY; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-427e5121313so1930415ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 06:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758893129; x=1759497929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xfmtM7RZ7AOffVFIOIyywezf5nzzWk/ab7a+2RFSGKs=;
        b=YmaFyvNY6BThLDSyckewMBBKy2siabHjS3koFbNTU4ZbRFC4ikmiWB+tvP2GkjGWgx
         hgQSVgMuVrjFl6ItJHTiCRT0zLyOGYKt875Xqv3xhjKz/53dXmlImIt1QVEwT/JUI5zE
         wBqqrwQq47fieVP6vvMU+huoMIKBAVkl/rB4xIZx1GeZsDq2he4/49IvpohRlzIhPVhQ
         lr0274Kw3B67v4dDWqyiqmWSS2ofOouaWiIu+VBBDvjD+EVnR4aOxxe3DLcGn0jzXP5c
         gXUFYMuBjQvbf2M7m7kYMh6KNe50TmDhpmYeUa3y/mqaHZUo89VrF6mrU3Ex3i6AncOQ
         vjzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758893129; x=1759497929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xfmtM7RZ7AOffVFIOIyywezf5nzzWk/ab7a+2RFSGKs=;
        b=ZFySf5iuKAu2DD7bPDz98a0tj02ku+5Pp9p4IMNkK2PXLfnlQQzFVQqN3YiBRaKFUt
         ncwXBOkaHwAb0JKpFrO4Ydy6xM9xzGEEaOiFuUSiiwbLIEeyumLsF7VHQHuvl89KTaK4
         LykEWMAeRjXxesOaY/FJ6T6kk5NrEu5wX8MgBGEwSKPQh+oZUQlyv8WyCbRspp1DM/d2
         0K4N5eF0syGUv7iA/FnztHv2f+FXMAE6dQfY9Nmw6Uc6RRpslfJrX5Qgb6gUdEkeEB++
         93pNj35Zyn99rktCT5X+lPkQW19n7ikKhuOrX9aEiLbTNY9snDJ1eV3teEGd7QYFBFCb
         Wkwg==
X-Forwarded-Encrypted: i=1; AJvYcCVgrWTsKUd7Ws0P7fTFgEMGRq8e9zAEVDQjdX2O5a1zPi3iD3vVdI3J1w4nJpr7cde6IZ1jHCL1Epum0NE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2stuxEElHvsLtKkNB+ysptmLusrqf2c2W8sYUcFQA1kvHSBzm
	GTLstx4NjOVnAyNT86ORACq7g28xKeMMuy9KzrJtN9/jPqQi0fGAzVXA
X-Gm-Gg: ASbGnctGg2uU4l9shXAkKNUQKtMSF44qDWHQDeK2ZOvDmaiAirV8lDXKAUkaiSwjxTl
	g9H8SRnqUSw2sWiGgtqmwlGrOaC1tD4J+GxqxGqm2jHYJhR+txZIpHa6wK7abJeTyjQxNaaI09v
	WjAxnnCKkU50Wk/hQEjTFwfEsjjIn1qY37m9m6akNkJDDp1dRaClbSkECASnhE6umwl42aqBu21
	6EKxI+72Cj+Yyh/NxMFHYYc4JQrZPYDT9ZTrw5fCnPl3IzFTCo1mv7kwXVMbpA4M1GqEmpOjeqz
	a9OV8OvuKCCdqIfhsaD8BEbAtbXoUEye8CkxgqMQXj3FKqWn/qeaB4yaGJxJ2Ek38Tpa2S3eGJU
	w6DgsaSjcUZZzPODpCLz3C0V/NUHFuEoP
X-Google-Smtp-Source: AGHT+IHuN12QnqYCBArnyQoijmnt/uUh4vZpuhcsJapYpJzRJKR3sYrz93g3wBFXERLf6b51Mb32mw==
X-Received: by 2002:a05:6e02:1aae:b0:424:7ef5:aeb with SMTP id e9e14a558f8ab-4259563befbmr99572855ab.17.1758893128569;
        Fri, 26 Sep 2025 06:25:28 -0700 (PDT)
Received: from orangepi5-plus ([144.24.43.60])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-425bcb5f6e9sm21946655ab.19.2025.09.26.06.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 06:25:28 -0700 (PDT)
Date: Fri, 26 Sep 2025 21:25:16 +0800
From: Furong Xu <0x1207@gmail.com>
To: Rohan G Thomas <rohan.g.thomas@altera.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Matthew
 Gerlach <matthew.gerlach@altera.com>
Subject: Re: [PATCH net-next v3 1/2] net: stmmac: est: Drop frames causing
 HLBS error
Message-ID: <20250926212516.68d35461@orangepi5-plus>
In-Reply-To: <20250925-hlbs_2-v3-1-3b39472776c2@altera.com>
References: <20250925-hlbs_2-v3-0-3b39472776c2@altera.com>
	<20250925-hlbs_2-v3-1-3b39472776c2@altera.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Sep 2025 22:06:13 +0800
Rohan G Thomas <rohan.g.thomas@altera.com> wrote:

> From: Rohan G Thomas <rohan.g.thomas@altera.com>
> 
> Drop those frames causing Head-of-Line Blocking due to Scheduling
> (HLBS) error to avoid HLBS interrupt flooding and netdev watchdog
> timeouts due to blocked packets. Tx queues can be configured to drop
> those blocked packets by setting Drop Frames causing Scheduling Error
> (DFBS) bit of EST_CONTROL register.
> 
> Also, add per queue HLBS drop count.
> 
> Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
> Reviewed-by: Matthew Gerlach <matthew.gerlach@altera.com>

Reviewed-by: Furong Xu <0x1207@gmail.com>

