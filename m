Return-Path: <linux-kernel+bounces-814171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B05B55033
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 16:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0131616BD5A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7F530DEC9;
	Fri, 12 Sep 2025 14:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ET9COeb5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B0917555
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 14:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757685708; cv=none; b=lsGAf3Cxdje28STGzwXdBVuBpdaAUqmFMnlWX3XMIYOcQfA1Nc0OlBTQF15fxhcylgtucVFXjWBfUqnJzvIefLzy6N/gsxAqo8vOHecbR9FWtOhLTRAg7RqRhZ2vx0nkqLhtE4xIqLA73HGcfQt0UjqLrD1ablmXpOezCoyqUPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757685708; c=relaxed/simple;
	bh=PRjCguMUk1s7Xp+w5iYJEY/+KMZLBNSqYFI/vEqfPmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RvpGIEmAHeavl+8Kve6hL3pgicZAGce8mfYSniM+VAgLj1f+UxArbYC/V3/MxgmOuC2su6CxdIZHIY2eZ2Rpv77debtwtpPo2zco+hqxhwWn+nZL8iniT1Jv42JEDXzfb4j+87A6qEOQ4QOjcF2qeGxGdl/v6I4SRyhNsWQaAo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ET9COeb5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757685704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MqqpI2kMloNbQrwtAbrBDd+hBQn+g4T03pkyyFvQVUY=;
	b=ET9COeb5UTSSd69Rk6I5GtlWmpuFAj/FUsy7ecU8ksVljatSchzLu6HQSJiYbOJZO+XcyP
	8rnnr5i9kFfiosGDcOT6N9rNHUZEORJuhCqTF79fSTCyFBgNxB+h1n7D0Mx4t7RHzF4EiS
	jqrVzi0K/vnHTI2k4HCWI0/pZGBPac8=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-424-bSJMfqQtM4i9-LIqWBaaQQ-1; Fri, 12 Sep 2025 10:01:43 -0400
X-MC-Unique: bSJMfqQtM4i9-LIqWBaaQQ-1
X-Mimecast-MFC-AGG-ID: bSJMfqQtM4i9-LIqWBaaQQ_1757685703
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-746d4801fc2so2523813a34.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 07:01:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757685703; x=1758290503;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MqqpI2kMloNbQrwtAbrBDd+hBQn+g4T03pkyyFvQVUY=;
        b=DqNTLNsQ65Wutd1iHyFkbaHG+zIz4HpQPCwqP/Aae7Z8AvrSNWn7lMmoparnhbGhPt
         NeYSsloajf06RBx00urN4p1xR2+ppf0d9qqRC3qkA7NWF4kfTSgYTSTXpLk4eb2zxdIg
         u/97V6i6Y+hKY2xe844n9/cAL17UIAAtwtKwXP9OviZfoJLyDESMVgmJW9VyryeF31BV
         +t8ooeIsHHYzbdfGk7iazifVSisbftnT2HlBiI+sMY3Z7WtMXkBL9FLRef8jnZvfcPVr
         /cVHze0EsXRj4ObXJDmmD4m0Ldx/zjkzOgxQ+OLMF6Z1adedREE8FgXK6d4gNnYPhyua
         nRhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNGYKnuNCEZwTy6bJpYMB8aSjMiV5ryILxABuDoQuwZFIkiz1jpgPqR0h2cwjMOP6FESW1cMjxFeVBZZg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnvlfcTnbNkSPuLvbRZsrE+lV0PJ+RycyRrsFzdsH6mNEYUtSn
	KK9ml3ZMOGqc/bwoFrxvfg4PuBfNYZ2tMm5wsr9vO3T44FyCiOJ13ocmcgy0NnjCkOEH+H4ZVar
	0ADqg+7am4F7ualGJo5Ewn/b01xLSWfpoiJJKqUpAo0XPK2wbKsxS4ZIlkoYZF4u09A==
X-Gm-Gg: ASbGncsOaG2F5VnaD13YanRAglztQc/RRkvZsWbFFmnETvdCmyl+qldYbPwL9Durl9J
	UN2e1BFiacTyeBkaYtgJ5eexwTNKSUB64HoiMDdZzOcWeC0ppNqqsTzm+QXjldnpgros7J/ykzo
	JP61nZlh6g4Lgf1Z5GLC3ROgd0yUdlh3f9mdbsqhQ6gLQBbZsMW30tFXe+D5xbOn2WM0MOzbb0o
	3JHwJupQrc0/FdLC/8w7IzBpMyRX+dhenl117dJRAAuMpKhztT90wManKH7VAxQJ9unafzxw4yp
	Vf9hrv41GafA1KZBYQWIOLTc2TNs25lXBjviIM/IjiMyjHQ89OZPdbOkIL6sAmkXfHxNad1YLVK
	SGYc/aY4ni355aCfLAuMNWV5l8WmoEw==
X-Received: by 2002:a05:6830:921:b0:749:32a:6e79 with SMTP id 46e09a7af769-75355ac0c40mr1629155a34.29.1757685702752;
        Fri, 12 Sep 2025 07:01:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5yxEH3wh5uzqiZ9fHV5ltsysfaNN7LLcUgGKgcfhcmP2GCkP3kLrFAt6qiJu3nESHP/mhlA==
X-Received: by 2002:a05:6830:921:b0:749:32a:6e79 with SMTP id 46e09a7af769-75355ac0c40mr1629088a34.29.1757685702145;
        Fri, 12 Sep 2025 07:01:42 -0700 (PDT)
Received: from redhat.com (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b639de9a69sm24487811cf.46.2025.09.12.07.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 07:01:41 -0700 (PDT)
Date: Fri, 12 Sep 2025 10:01:37 -0400
From: Brian Masney <bmasney@redhat.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/5] clk: Introduce clk_hw_set_spread_spectrum
Message-ID: <aMQnwU3UA5xe-Eou@redhat.com>
References: <20250912-clk-ssc-version1-v3-0-fd1e07476ba1@nxp.com>
 <20250912-clk-ssc-version1-v3-2-fd1e07476ba1@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912-clk-ssc-version1-v3-2-fd1e07476ba1@nxp.com>
User-Agent: Mutt/2.2.14 (2025-02-20)

On Fri, Sep 12, 2025 at 11:35:51AM +0800, Peng Fan wrote:
> Add clk_hw_set_spread_spectrum to configure a clock to enable spread
> spectrum feature. set_spread_spectrum ops is added for clk drivers to
> have their own hardware specific implementation.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Brian Masney <bmasney@redhat.com>


