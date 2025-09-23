Return-Path: <linux-kernel+bounces-829657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F116BB9791A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 23:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A23EC2E704F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 21:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1CD30C617;
	Tue, 23 Sep 2025 21:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bPqx9QOL"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA8B27F74C
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 21:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758662814; cv=none; b=niSvjoimpk7AzEQfjqZfQpPtC9IExSm2tO/5Cmpl9/XPvonVR+KGiFbhY45ngAnUJ/nyLP+dX2eQnIZv/ceMt7r4WjaH/wmxP7fmNM2jwKagDhY2Dzo6190cNemsHk6uWh4AwmNOD6vKRZ4uISYFVrjh2JJooR5MPVD/PYNmsBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758662814; c=relaxed/simple;
	bh=98TTorsAAC5opB5uJTgkfC0e3/EFtVZUCwE9L5IqI5I=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=eYBIH28JuM65fqgii3/GieA4KOt4cVpC+cSpPwb1p+uPEJqK4ihIPA4Ko+fYdVDr3OdhdR7PFf2wCHImy9jsdqYtGR5B7XloP6LWTCITTeVikOenr84Vm+//IprXKQxzcOc6WR1olfkE5UZchHVym+kw+BoXi8S9mh1UariKXqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bPqx9QOL; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-84d0386be74so224936885a.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 14:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758662812; x=1759267612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TzM+YAdlSU/VZW+2Cq6jx12e0U5MbjPEMSsvWJfPo/o=;
        b=bPqx9QOLaXpHPp/Dh+Cr2IIHQwxDWy9cz3qqhQrTNIVFgpCdukzDGxr0xsWJD9LzHY
         Sj0yoM0n5gO/MCCI5P7407/MK48qklBQA/b7cQ2mRmKJG7hQwLArXF+jv4PHGVkyFQ7M
         kQJMwJLxoiJF1aKRKcgsobGMN0G6YZpviIdCTh0H6rwwETnOnJwS3tIXUbWn7BEj9GBY
         SavlvAPJxqN0G+ms0g4Wx602Df0noXwF+9JYRLe3/otPKrA6/SpyB0f6T5sZsyBkRBi0
         Ajssx+uiwYP0VOwYmTtYHN9XH+DyNithD9uXF8vhmF/GYxZeRjz6/zrKoBdAxZD0W7ep
         sF7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758662812; x=1759267612;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TzM+YAdlSU/VZW+2Cq6jx12e0U5MbjPEMSsvWJfPo/o=;
        b=mhIuq5jbxZMrbXQjiGYurOuhc/sMeD62Ncd4/Muz1/1nmRM/oY8Y/pzPBAdQNvLupt
         KHYkkFyb5nd5qcn7r3tVlES2ZhVzvnX12wsspiScIXc+oievwSw00IK9JboaSx4IUIYb
         RRNgUHyNnkGvcV9pSSjb4JNguDvVgAFz1EAyWCOzfVbVgH/ct3jaDlVGi7iLNfgFsgRZ
         RqxZwga168R28G4IE0JM+5XNb15AO0MElgfHwjwvGa6iJhccHPCccdqOLVkt4yZGih0b
         Ov0qzssAFrh+M3Ftc6/9R/hImbBk6rgSPLl06zj8WodBEKE1Mc5W5xnIMUCbs3hwMW2y
         yjWg==
X-Forwarded-Encrypted: i=1; AJvYcCW4rd+XtOenFWh5LtqKkHFws5MAQorMRXLQhLh4KZUwNO7ADWKMUnem8ux2mObnPIfWXnSjmHZFEN68qf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhCAyYQf9l8j1CB7WwZXpR20E6VpNICfYODUBAjdFdpna0HdG0
	RR7gyICG4OXaShL/06Ur3oHQvvKNKPmOJkZY26VI+JSksiVplFSQxzNq
X-Gm-Gg: ASbGnctELE9v3r+6sZqZPm1ovS4y2eyur/laYK+rVhHPwPirMFRS8XFSBEoZhZs1VeI
	rL6LHFIeMBZqV884Mdc9WZbyn+AkZRyNLNqRAKkm9aot0vJfj7K3KInMz1XlwYf2h2+PwAuus1B
	hcXpk/kcVOjbon5WYr0QvZ0SoHoytM6SqJ6KUcexhsZAs55n37LK2g4XdoW0+Mb57eWZzQBCFhc
	TUDophmQ2YMvQDn6V5T/MeDRlUM69v5cVpexXCLx7XHCIzQSWYjg7wZqSdMElp8PIwuYWPmm4F0
	DaOeG0MiGGANP6ndDEvvllFZArVj6ykgTxJnEag+JNJo6wKoeRtUIuzmC7syxm4HWsxyv72g+Yb
	yt9Q2dorzKGUjx8hjZvfyBcHtR1ild6YbE+7W30ZzRIyk5XRndkbtWwn8ylmBvA1VentyQQ==
X-Google-Smtp-Source: AGHT+IH8atUv4YKSIxfZVb6zK7i1Ycf2XPhQsuhnYzuHVn6FuO+wM4OiWHH3TWoKcLdGgcHi4O5NpA==
X-Received: by 2002:a05:620a:1a8d:b0:83b:d570:acba with SMTP id af79cd13be357-8516aa0ddcamr431669185a.29.1758662812136;
        Tue, 23 Sep 2025 14:26:52 -0700 (PDT)
Received: from gmail.com (21.33.48.34.bc.googleusercontent.com. [34.48.33.21])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-83630481f38sm1039458585a.39.2025.09.23.14.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 14:26:51 -0700 (PDT)
Date: Tue, 23 Sep 2025 17:26:50 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Richard Gobert <richardbgobert@gmail.com>, 
 netdev@vger.kernel.org, 
 pabeni@redhat.com, 
 ecree.xilinx@gmail.com, 
 willemdebruijn.kernel@gmail.com
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 horms@kernel.org, 
 corbet@lwn.net, 
 saeedm@nvidia.com, 
 tariqt@nvidia.com, 
 mbloch@nvidia.com, 
 leon@kernel.org, 
 dsahern@kernel.org, 
 ncardwell@google.com, 
 kuniyu@google.com, 
 shuah@kernel.org, 
 sdf@fomichev.me, 
 aleksander.lobakin@intel.com, 
 florian.fainelli@broadcom.com, 
 alexander.duyck@gmail.com, 
 linux-kernel@vger.kernel.org, 
 linux-net-drivers@amd.com, 
 Richard Gobert <richardbgobert@gmail.com>
Message-ID: <willemdebruijn.kernel.2d533675f308@gmail.com>
In-Reply-To: <20250923085908.4687-4-richardbgobert@gmail.com>
References: <20250923085908.4687-1-richardbgobert@gmail.com>
 <20250923085908.4687-4-richardbgobert@gmail.com>
Subject: Re: [PATCH net-next v8 3/5] net: gso: restore ids of outer ip headers
 correctly
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Richard Gobert wrote:
> Currently, NETIF_F_TSO_MANGLEID indicates that the inner-most ID can
> be mangled. Outer IDs can always be mangled.
> 
> Make GSO preserve outer IDs by default, with NETIF_F_TSO_MANGLEID allowing
> both inner and outer IDs to be mangled.
> 
> This commit also modifies a few drivers that use SKB_GSO_FIXEDID directly.
> 
> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
> Reviewed-by: Edward Cree <ecree.xilinx@gmail.com> # for sfc

Reviewed-by: Willem de Bruijn <willemb@google.com>

Thanks for added the pointer to segmentation-offloads.rst.

