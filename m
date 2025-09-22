Return-Path: <linux-kernel+bounces-827790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE766B92F53
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 21:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C7631882C1F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 19:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD602F3623;
	Mon, 22 Sep 2025 19:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LN2dcCf2"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820332F28E0
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 19:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758570010; cv=none; b=DUP9RiRvazm9zgzO5WF78G6l737Wu37W08PbBW6Qywk2yIHS6J/HfwYUECavuEnQzG6iROOPlmo5LeZoHtOUlQHbmHU2ubaob3Fjjh9zlQspYh4VgPvJ1faubE/JwgUamvlZ6yBnzHGyy7Fr7mlOwnCWLvjkbD1evKPuFYMRfFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758570010; c=relaxed/simple;
	bh=JOFNb4TayGW146eeSR/TzL6bQPiJFXPSs3/rt/QcUCQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=S16BnUttLXSJNLgr0ZdK+1ntZswj/LXjChXUWI0+umllhUrBcfZrW53LJZy1zBdiuLXXWGnGVjWukdMVLV3Q5b+/1Sz8Y+Xo4SUFd7SnnXj66ewHjxg61nEx0FSlPgzBkwhF7kZL6nX+Sk67yaCzPIMgY46xHovSMCLbt0dbT68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LN2dcCf2; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4d142e9903fso7468221cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 12:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758570007; x=1759174807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AeJfCOIdqssbRzmzOiSYJt0e2DEgh7LHCqhy+a6iUYs=;
        b=LN2dcCf2N2x4n7xNcTVNgNcy+umn83GQAy/mbCbfCUE7QKncu8X64nLOJZQvuoxNQA
         MbF3ZZyBXGTAnsAUSiCWeEN2if00UA8e7/GzdY1QUwf6Bu/KLh8lWXNuFF9s7H+I/8Pb
         J7AJ7iUPJDeNhkGDlA8dk1eRyX503GAhdBNQMjQLKBRXCF707is3FRkDw0MU41kIy/oC
         P0NHWiQPqs4o8OsXf8nAdtRVlg95wTFsqZDcimUnWXJ8wLo6mte4OX2u8tKwZiwYKrTI
         gUQ94RLqJzpAT03yfVVn2ESECdLJPvn7RSEuZWxrb+L0MLQ0IEyxqQzG29EPdZkuZApt
         V6pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758570007; x=1759174807;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AeJfCOIdqssbRzmzOiSYJt0e2DEgh7LHCqhy+a6iUYs=;
        b=bu/AXTlPOhwvr9txry3PDchaGQfv+NkfRcBn0Q5JTAWk92xOJO0jaIVttF+P7mkMis
         2mCjPSN8DHTR5eZL9pc+X5PvCoLNigaULgrhWe8LncXJGGdSWaWnlEAAUNuPvKl2QEFi
         UDrFxVG0XU1b7MCmaBCbJJIDRUT6Z+i71YhG12yBXcEnmcBp/Mk72XiSZHFhGKeP735H
         alAagSpAkbI3Ob8EB8ylomJdZ1S5HMEplEZpmA36qMcWHZ69araVjRPa9dd3FIlbEYXP
         Dm817PkhnPMtCUSJ/4XZ0PrtErXCBFNGNjbrqRcBQNdCHsjl64qi0He8VzjTX5a2MDLO
         vRLw==
X-Forwarded-Encrypted: i=1; AJvYcCUDqN1NcRPm5Hq7RG58Rrx1BbJl9qAmS5jCyy33RKifREt8z/8fm/WA2MVcpjYNfpm00njiegcjgBNTxiU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBWTXbFl2/z7f9cebzO0JzpWW2l2/WWb26AG47saWt4MOfmS3F
	SaG/Cr26cLA+1eHRq0uz9QGhTe0EegL6Bn9yU8OYjGgPjgztqAI/RZOn
X-Gm-Gg: ASbGncucv7J0eFvWxWlLTK1UU+jj3y6nyc24ungQ7Q5zak4eAhrElARQzwD+ygnHVTo
	4dG3VGWCL6Y7oJ2wGLOOTgtfu4qz9u7d2MBgZQqJFaGnXXlFS8htXzCWi/EO5jFHPdtp2iIM2T/
	PwEIQD1ZRRPx2f/0R9Gm0Cb1b2lL8xssOMAxzyDIbwqMGLVld1cG4i2zO4LX26wHb4EtnYpQtZY
	Xeuk9zohflmdtucm2EM6OHU5frJEB9Sr8LPpE621BqjeffK4VxJ/nyPl9+hlocg7+qGrvUCZ/kW
	l9GRxvMJQJ8H2WRpPxhXdix405Yx1Qof5kg7XOPo4ksAXZUjV5pjgBoEaXgHJ3pkCHIZua9Vz1i
	KCFulX3QwpZ3CmKSCjceYXrgA0UMm2oS/e1bCjjfZ97LwbGq6MMfs+gXmPGNY/dBP7hZ2+4Zia2
	+IbKWI
X-Google-Smtp-Source: AGHT+IEWlFIqa7hJ0cVGA+SxXSjuDWSK/kwgQm4BwZ9QHtqSUqheIi443AUHtfztTVXUz9ka07qpCQ==
X-Received: by 2002:ac8:7d0d:0:b0:4b6:373c:f81c with SMTP id d75a77b69052e-4d36aff5c0bmr159961cf.30.1758570007205;
        Mon, 22 Sep 2025 12:40:07 -0700 (PDT)
Received: from gmail.com (21.33.48.34.bc.googleusercontent.com. [34.48.33.21])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4cbc4ff4e84sm19850741cf.42.2025.09.22.12.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 12:40:06 -0700 (PDT)
Date: Mon, 22 Sep 2025 15:40:06 -0400
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
Message-ID: <willemdebruijn.kernel.1262069e9a3f5@gmail.com>
In-Reply-To: <20250922084103.4764-5-richardbgobert@gmail.com>
References: <20250922084103.4764-1-richardbgobert@gmail.com>
 <20250922084103.4764-5-richardbgobert@gmail.com>
Subject: Re: [PATCH net-next v7 4/5] net: gro: remove unnecessary df checks
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
> Currently, packets with fixed IDs will be merged only if their
> don't-fragment bit is set. This restriction is unnecessary since
> packets without the don't-fragment bit will be forwarded as-is even
> if they were merged together. The merged packets will be segmented
> into their original forms before being forwarded, either by GSO or
> by TSO. The IDs will also remain identical unless NETIF_F_TSO_MANGLEID
> is set, in which case the IDs can become incrementing, which is also fine.
> 
> Clean up the code by removing the unnecessary don't-fragment checks.
> 
> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

