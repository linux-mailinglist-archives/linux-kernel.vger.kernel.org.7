Return-Path: <linux-kernel+bounces-741617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E75D8B0E6B4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 00:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D316D1C882E4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 22:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA9F2882D2;
	Tue, 22 Jul 2025 22:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="NQbMiq6r"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF09721C190
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 22:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753224624; cv=none; b=CYvKJHY8ekdbkFuqKdQydW3jb0fT+rRHUR0D2+S0yPF/Bddpm/CD5iF5cRIz0Xpodrp+XhZR538eLbEJrfo/tyx6Il7dawgzLpqosMqo28a5cdNOpCou8/2QqvhMfJXSOrJ4R4nLAHtXPc/d6Phr2f278mbOJW9THT3K/6UHLhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753224624; c=relaxed/simple;
	bh=enAcN10mvlsFzRAtxkyXhmWPR0Xzn/abi7ke2a+kaZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EwRfuVXvBAHRNXYmWE858I+nFclNy+hfqURelqWVOrk5DhZwqWT4CQ8EG2XpYF8rZ7MV/wNk+KovbGwrPELemcsq3MKtkJq6U0y6IoZ1fXPkMPB1wV5g3UvWDuDV8JV8aOFU9lHXWGDFZriZ+/TosogFWz+N8VlM7nmZ1jLOp00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=NQbMiq6r; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-235e1d710d8so65580135ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 15:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1753224622; x=1753829422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g/vhVxMUqtZpT10bNo1OFTBNDsTJRyeeSF2rb6zaHQk=;
        b=NQbMiq6rS1PHp8uFj5vixSvo4cv/a8Mao0IFy3pq3zpVO8EPwhUFCy22i+GAweZKa1
         pKgok2iu/x4hOFuG+0q2fX44uvKWxYcFlJ89fu+dFLQ4rV5lxLS/vA+KJlvJ+m288rEV
         DPRx8qRnL1LZvH33+4oSJuL6Z0GzBww96ZQi+pg4tY7/RWWXsMTHW5NTwMXB2L/Ll3RZ
         5Hxy8mO0yHWYuyX+Aw5Lm+1yWWC92gBIeLnLi7fajWCiTAApK4hE1BXmnt5bnmQv+y1o
         nxpNQJpzod/OiQv0nqAdzDSXWLFa93gghh++Rau/d0sr+wsmusjAXKvxf7iQi5Rlw55e
         x19Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753224622; x=1753829422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g/vhVxMUqtZpT10bNo1OFTBNDsTJRyeeSF2rb6zaHQk=;
        b=vQIaD1oERNTP7XHsRirPmaqw4HzUmGTVLfznobagQ9P7h72kSaz6CnaBcl+NifE0kJ
         DitEsW9rVID4htUMvLqVM5b0piBrvqetpSwZJcZZyNFQWIaHbWj1XW9P59Am5ytpPgqa
         P13uyCWwpmfu2wga0iNX1LPV+M6sT9enpfpdXf0pZgxFyM5z0K/ofPeruleQWPBuKAjx
         pnE1jXGt+geN4pPB7rMcSvIww1+wSZpEvdMNe2au4CRei0b9CxSiYwcqvKp4LK4Spgzm
         +BbfgT2lSRNGyeDdgZvkWi/4p9pIs7WZJTPDWbOpIp1ECukoYTquREq6u3uMP8aXqkPQ
         4b5g==
X-Forwarded-Encrypted: i=1; AJvYcCWvv+3kX+2TJKQSD1PbtTKEZ3YfQBdjszCAaQWDWZBbkluZ8GdHLBY6dmAANz51LXO4ar6Ns99TNoP6Fvo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfpB+oAX1rwne4xfJDgKvBfcujyy+/817p919yyimf7PLmIXU0
	yh8hgQgI3jopDTwblVlKQuLthf/93O6QXxjCL2ECgOTR6DWyMpev/7Iall9IM3robwA=
X-Gm-Gg: ASbGncutHtUy3A48M5Z6jmbYOLDHvF53cuKU0OXlsriDdRX/S6VRGHVWRiZc7YdTcEg
	bK3KKsomeh8IqPmd9fFNdMAynyR0C7tQWOKRX/8Hc9X7d4ILXz3lMzJD5+amemVX2n+9o/LQxgh
	6jkOv5tx3SbXKhjaKpSlMeKIdMdVxQ/Ony4dr7ftPy5TyOa0B1flSi7g8DQKTzlEB0F2q/v3uKu
	emlE7a1CPXJEEZFpcei+nix2qTjRNMjCP4lJDB4rjTzEHYuKiHUNEOh7rOEbz8VOP7RaNfUfJvJ
	mNKWcwIthtfnp9WhiWY+ZLpy1ywmtKVj7A8/I7kjuFFf9EaXhDdWT0T6Ko69zbjbW18xhwNcpLs
	GkD6SlWF5eGb+lRear5zK4FCX6WRPM+iTEnGZu4HvDF/i3E+PyZVrHAO7nSoxBETEXaZfRqaFce
	tJn5jKIh7dHg==
X-Google-Smtp-Source: AGHT+IH6QdqHikvWWWFS4uMo5fel9o4AvXYJ/Ulv5jITj0xamrgqfX0KU/9j1DVayEGbpYtj3tpDGw==
X-Received: by 2002:a17:902:d512:b0:235:e9fe:83c0 with SMTP id d9443c01a7336-23f98194d3bmr9282545ad.27.1753224622089;
        Tue, 22 Jul 2025 15:50:22 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6d199fsm83474425ad.134.2025.07.22.15.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 15:50:21 -0700 (PDT)
Date: Tue, 22 Jul 2025 15:50:20 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] samples:pktgen: This file was missing shebang line, so
 added it
Message-ID: <20250722155020.6f73f632@hermes.local>
In-Reply-To: <20250722221110.6462-1-unixbhaskar@gmail.com>
References: <20250722221110.6462-1-unixbhaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Jul 2025 03:40:18 +0530
Bhaskar Chowdhury <unixbhaskar@gmail.com> wrote:

> This file was missing the shebang line, so added it.
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

NAK
This file is not meant to be executed directly. It is sourced from other files.

