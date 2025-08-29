Return-Path: <linux-kernel+bounces-792564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C88B3C5A0
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 01:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 350B61C80C5B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 23:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F4B270542;
	Fri, 29 Aug 2025 23:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZuL4El7z"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003F1225417
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 23:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756510635; cv=none; b=C7qxmUII9+nlVF/8LFsnBebc1J86Uw56Eokts2zft6BVIJrCTEwA2fx9EVTvvVfcIC0rK1dAWPbRDVzHmd//skxs1P4hdYEHUED7xP2cbfSi1Dp9mz6kS0dg6qz2aTmugnXJ+yKp3IPXFs35H16hxgWXm8j/gL13riy6N9QnsSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756510635; c=relaxed/simple;
	bh=SgGHePAxwq5anH5zBqiVaIBk+E9bKo41zh84tJs+ikk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IURsapFiaDi0e00PyPlgCuinTbTh2W2zjpCBqOKNJ3wXXvsIrjWgpHX+ir8zHor7N3dNIbTZ3HHzNidokcCufwC7KrlI73HcsL9bVw35ms4tk0huSXWIosPKBQbVNEULgrqomvM3ump8ucmnnu229FJN+bFIc7XCRV4HPk+AItE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZuL4El7z; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b4cf40cd0d1so1059318a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 16:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756510633; x=1757115433; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=glS3sDuuGoAFcVgGKRUacpCdPCUL1DR9254ZlAJsmig=;
        b=ZuL4El7zxC93leTeVSocsKqmkE6QZNtEU6LmTAJAPDd1j5CyHbk/KkLzCA9JUf0iKH
         fXBYeGnj+pCIH+RJAzytq9ZBIIf9NpNSImYSK+/x2LzxhkqZqa0dsFZ9DT3bzMMWyEk/
         YJqpvptH+U3ZqRz0SYZWqpJQVtp6qTdv3TRVsL8BPc5Xt8cWSQn8135uFRJC9Wph9zL2
         2dVJ4ltk1tZweKCyQ3TL18Gv0yVWIQlmJHaP8b4d9wCv/deceHeSXZsFYh1cnbTaJUJl
         cIEChZhP6d94jd8KDaBjJq91Y9wRXtvRdZX3s6aWc39LuG81qqzDjOcVGYh7Qoprc8kN
         EWCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756510633; x=1757115433;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=glS3sDuuGoAFcVgGKRUacpCdPCUL1DR9254ZlAJsmig=;
        b=n0F+6Cna94So2gyiHAuass4gz9NL/pzN4nRo62xORvubPbFaK7XmV+LwS+f76LnTOe
         UhkP5Za1S76BD96iDsZTTFK+ly9IbUn9xUcZFU8436DAu7o+W7pdY8QlBvoMKoc9wwJ8
         fV157iZy5NaEL7qoQQ8kz98/M9cZAh3MNKX28ElwHx45KhXqQ8BTqyBOGLhCJZ6clmAL
         7PDzVGP3I0eZhuU6aXmroG3XcVHsjmM2B3P/MpaGM8Ppg67Z+A1LAO9pSM5P2zPhLeNP
         T4+bjmttS9M2vKbvVeeJRqyB0uYrv+B9JMOM8+SSNiS/9AW9aaWh+I+t7Mjax6kFvnrb
         bBiQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3mKaGWeJT1/MwlJeAaXGdyHtdR17VOyNOdr3JkFkPz9RnmjWmGtKbQkQEsSXF8I0NdQ0PSYzXvOrO+VA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8etGaWNZWpxxEaIcziSmcct2YGbcUmA6PjhVM3xFaAwhtFPix
	IGMbkg7nSENEyWMnk6cK8/oL0WVt7He6l3yWfNLFMFAufYImJdqKW0aw
X-Gm-Gg: ASbGncsHDZbAaK6hNXr8PFR3XBNeupcddSRYGY04fy0RycsNovZ0SoGEF5NcBNVo+/j
	6BiiaB12aTzKtgV6LtJ7M6NKXO5tCYrUA/+0RFOcF7gj76o+SmXXrmp6KsWTwrkkISVg1r7aGrE
	e5g9JH4k6cFtAZ+N5XsAeeF9hnrjxkYOK+GjNCU0EduSGAsLk4IIfi7fzCjRNk1+mgSUFnqqXeb
	KBGPslxRMom3xsFi9rDYyX5Iatub/ScECd5aIFxhhpghv2BIvjnT8PS6Z5+OiLbTZOnqD+nOIWa
	xSzud5UTPNNuUFJ9u42Ff78OOenNafu2XRQrW++9SNB/vpa1QNu13aFGpVp3vvKBf9nE/YBowvj
	xdITq6TWXJOBvKJzpAiqsclWsjQZhz6i8ZNWtU9CIQGloTjHsvfeoKA==
X-Google-Smtp-Source: AGHT+IEPKsWyINA/5OCwHsDa8dMAPLFlmlltwSr8LA5tQwEEhdGovo5KtOdnVVjxX+/e01qwpKw+lQ==
X-Received: by 2002:a17:902:f543:b0:240:50ef:2f00 with SMTP id d9443c01a7336-24944a0e817mr5201615ad.26.1756510633134;
        Fri, 29 Aug 2025 16:37:13 -0700 (PDT)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3276fce1f30sm9433712a91.23.2025.08.29.16.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 16:37:12 -0700 (PDT)
Date: Fri, 29 Aug 2025 16:37:09 -0700
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: akpm@linux-foundation.org, david@redhat.com, axelrasmussen@google.com,
	yuanchu@google.com, willy@infradead.org, hughd@google.com,
	mhocko@suse.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com
Subject: Re: [PATCH 09/12] include/mm_types.h: add `const` to several pointer
 parameters
Message-ID: <aLI5pfQIJWewLK-S@fedora>
References: <20250829183159.2223948-1-max.kellermann@ionos.com>
 <20250829183159.2223948-10-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829183159.2223948-10-max.kellermann@ionos.com>

On Fri, Aug 29, 2025 at 08:31:56PM +0200, Max Kellermann wrote:
> For improved const-correctness.
> 
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>

Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

