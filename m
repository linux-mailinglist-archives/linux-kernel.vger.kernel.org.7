Return-Path: <linux-kernel+bounces-810734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E19F5B51E8F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 19:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BBAD1C878CE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 17:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914AE2DCF51;
	Wed, 10 Sep 2025 17:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uspPnEsp"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7C230DEA5
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 17:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757524024; cv=none; b=JikSNwHlRh303oHa0v5awmz8qRGnxTjiI+ri4rOIAcgyqAwchhtuKgo1F7u+LW7eLPIfXtgNjyTDnoaK5EFt3ryxLN9BFzQdysDoholsujVpmviR8NVJ8M0N2D5+oQVJyuTepwMqJX8AqhzKYKZ7BsTaDGEXqA5w4tJeQ5Noapg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757524024; c=relaxed/simple;
	bh=7De7/KamC02E2b5EHbxS6ATHgldlo+QByCWY9AZEpNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IGjYg59owqi0EdYLq7s0avKd0JFrjiyGV4Em8pU0yZ8Zk5YY4P2zT26kuWu1fWsI9lxjYspsZuZxNcJTfQVVAwo1w5D4RDTHqeT4ZPtlMGuJNFSEzX2PZBNJzWGCNls0kHI9I3YpoROHih9YRIr/oizLuYA1pVl8WlJ+hqzcz58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uspPnEsp; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3dae49b1293so3635462f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 10:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757524021; x=1758128821; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eW2e8p73Sm65C62B3d7xoYycH9WMEA7fbE5AMLTODfI=;
        b=uspPnEsp75Gdyr8PFtF7nwZCiUpV0Q80+b7q9ToT//k51OcBu7S7wJgfaE/28+pJ+p
         L+Ok0iM9VM/CTieCYeGz06ZvEbfqMTtfmdIMx4eCJI5l7JSuzkIPUvW1yvrL23MIawtH
         4O4yzzUREsV35mPm4nV50mfSJLyMX7E53OaQLODiVIECEQLhHIKkIQt3X+MfA8LKF8zX
         LIqVbZT05s6W+CS3q1rwWDRBOxpAH/upjbkn2bXXqvp+/sPDuT8Kf/8iK7nPT7sJ4sWX
         uaK2puq/4bXE0DiHGCwVF5hY4uPRfKC5BqhM/kuhkw4T2lprWEW6NKdnGkLRjr8SxccP
         QlrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757524021; x=1758128821;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eW2e8p73Sm65C62B3d7xoYycH9WMEA7fbE5AMLTODfI=;
        b=vFOMZ/k3eaoKC/R8O+9+JFag0aQ7S8BUauzA9vlpZokmdAZmOR231yX4b45826iOFg
         0Xt+yWa2nWXx1/Y8xfAAZDOrdr5+ytPmN96Y2RTrLAVzobU8HCeuNlIPK7ulqziNejw6
         7sdTb5D+WDsVEfi0pmt+3ufTrNBxR9fz2H+CtUwLl6GAIZFUCobTFQjFccbwd+h5u/oO
         BLXZ7E8/ddyywK94dfIO4Np7a7LhjL/GKZWSjGdILm3A/OXYN7QXiLv70gKurjd74r8X
         xvWMJWPRxoLeZaNSsv7rl+iEXiKjgTN8s6GbbA0+0tIwHgmsSQv7VM4rLZZ398aqqEkF
         zmbg==
X-Forwarded-Encrypted: i=1; AJvYcCXk48vIYQZAf0BzMepTlHSEasHsgthCi9bTafsvrZwVSurylmC1p9uydubeTJz0LhaPmVxwEseEsRZ6eE4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxloAsWupL8DFvnKpeIKIjyhppDrCRyOzPzO+0nOnkrB9MDPxTY
	0/9yDaqu1spJazmzwat34V1zutaN27tlF4IHkIEZdBjfTbmeLvmOojXMoUWWrpa7VQ==
X-Gm-Gg: ASbGncuJAs3l6atnai0GGYN/wr0aKDJtFAU9Ix1Kq/B8Tv+s96ZZPTfiA08sdDmHJg9
	VcNbUXpFpZfDrs/NDN+8ZcXtOkj3x6YJRV8fiBWcnVlAYY8ZSkIQf/sieRg1WxGK0jioWIIqq3y
	zNP9pqM3G0FjWNZ5tFygcDV4NzKbBfwejY84lU6vRDSgUXZxWoS5W1fxVMt5YvkvOs6kX1YNCgx
	psvYpYfB2sosTsVdJ4uW88DNZ8qOmDliTm6gXh7ql5CMK0pU/Kduqk6EpfE2UfPJ5EiTfVPLPYI
	mZlij2QkxVViw6vo5Z7Tmmae66d1j6E5xYIXzUvcOavz0ZfjmMAjdiTfVEbHagwvhssLSEXTVQB
	eo8i8SGIUrTGufg7vn5hWFFUUE9NTHujqrglLFhUGL9ssajiPdboBCMs4WXIljNb0th8b6S1T/Q
	Pw8iizPjfrZ0Ph/L0=
X-Google-Smtp-Source: AGHT+IFpMY2LdotLVzenSyom37/MyUBFp2vGP8SWQXN5ZGAgsTxLPg9ujzG9esizRfQMqbIwV/AfZg==
X-Received: by 2002:a05:6000:2f87:b0:3e4:f194:2872 with SMTP id ffacd0b85a97d-3e64317ef24mr11131229f8f.31.1757524021156;
        Wed, 10 Sep 2025 10:07:01 -0700 (PDT)
Received: from google.com (211.29.195.35.bc.googleusercontent.com. [35.195.29.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45df8247c3fsm34826185e9.11.2025.09.10.10.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 10:07:00 -0700 (PDT)
Date: Wed, 10 Sep 2025 18:06:57 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, jstultz@google.com,
	qperret@google.com, will@kernel.org, aneesh.kumar@kernel.org,
	kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 15/24] KVM: arm64: Support unaligned fixmap in the
 pKVM hyp
Message-ID: <aMGwMQBwxRPPiCer@google.com>
References: <20250821081412.1008261-1-vdonnefort@google.com>
 <20250821081412.1008261-16-vdonnefort@google.com>
 <20250910124742.34185645@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910124742.34185645@gandalf.local.home>

On Wed, Sep 10, 2025 at 12:47:42PM -0400, Steven Rostedt wrote:
> 
> Would be nice if the arm KVM folks could review the second part of this
> patch series.
> 
> Vincent, I finished my review, and you can post a new version. But it would
> still be good to get some input from the architecture folks.

Thanks a lot for your time! 


