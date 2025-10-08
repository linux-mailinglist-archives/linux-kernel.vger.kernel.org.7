Return-Path: <linux-kernel+bounces-846001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F2DABC6B11
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 23:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10EDB19E2189
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 21:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FAB22C0F8F;
	Wed,  8 Oct 2025 21:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pinefeat.co.uk header.i=@pinefeat.co.uk header.b="qIy6MKyz"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC4D1DC1AB
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 21:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759959157; cv=none; b=s+MXacRHkfTHfWRnKUxXTUsMrcdSP9wdv9WQj7gAWNOW5wG6JlFbYDHFVhOcAt/hhPWh5MsPrPHejKlP5DLjvXGlGM9wCWxqAYsVxac/yCtXfcSBaj/ZdXLmvMCnWliVB7nGBZUeu/w0bXTkuyxl2S5nYjW0o/gfnd1nX6Uxbys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759959157; c=relaxed/simple;
	bh=e70Bs/O5EAKRWcYxVR2GwoG02d0actk1OQmwEew1rKw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Cbfuy/Z+v1Hk/fegYEiN6oNFuICs49GVoL5H8kFOgZb4c5OqHDR2m2rJZkfuCayia3oqJFi4OoWEOXpi0mJhoYHbj6asjeKXD19Ig1KcwlPTXsKVeeec9I5AbadtNNIR37TEy2fc1uX6xsVabQhMFeCZbpEgjo0NCQdwFC/A+JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pinefeat.co.uk; spf=pass smtp.mailfrom=pinefeat.co.uk; dkim=pass (2048-bit key) header.d=pinefeat.co.uk header.i=@pinefeat.co.uk header.b=qIy6MKyz; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pinefeat.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pinefeat.co.uk
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3ee12807d97so387965f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 14:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pinefeat.co.uk; s=google; t=1759959154; x=1760563954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iib8S/atLqN/Z8rYxef/QQXPaAWrsYEKhr0SHcC79yE=;
        b=qIy6MKyz0EoO17TBcV9sZV6hPnbhQ4N1RCTtb7loFX72MQeoSJspWQe3obPVzjLXpS
         5Jo+8+agFK++Q59Dvt+vEHJm6u0sc4q/osxm6qLoaO3z19fRBYkW06SJStEw9CmCgOOz
         W2IOf+CJMr+6Ljk7AHtOEKLGl7lGe3xC/fOqqskFmABpox3/dC8cF1yYueXg22pcIraA
         NIriJA7jXCyfCAQpk9gBFgzwtaLr6ddt758Q0nOx3JoT6eTl00sqkP3OlIk72L/iO9+k
         BCrKaAby6hTGeakxMlvGQ6IZ3SB9W77l/boJr9k8rErm94tpwHvH/Uqt7zf4A5RVMdkB
         2ZyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759959154; x=1760563954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iib8S/atLqN/Z8rYxef/QQXPaAWrsYEKhr0SHcC79yE=;
        b=no+yItjv2u+7iVLucXLuLWgG/V6BVUc7bVGyLbKxuLW1JBwQcydzGoA5elrLJ9fSMS
         Em4DMfaQJ2en4GzES3FrUmXA9kJwBcoiDlT6C53xUax0pLDwDMpw73SQLzH5ZMMw9Upw
         RXlzcQNg0J1qozUO2yMqeWivUtPbAw01F48Nbz38vI2B44Mf90cS6MIGhwhgIHAwMzEr
         pwHipBUgWfjQqXZmehp2S8puSQVGE9+LEsdCtRtmoRaUQtV+mT7YmMHxogtM/Jna3ryY
         rPyl6/F3PZj5e8ZGXpbj8Ts/R6ka2GGEk7yXkTs1tXIGNgD5uBH9VZPwYRHKG771sa2n
         IGYA==
X-Forwarded-Encrypted: i=1; AJvYcCUus9p+N8UxNomI7kxT0Hslhh4UPkzOXOUaEuk3hc8oUtwEDM/VEQ76e3RK/TrwF6qxE51lAAxZJlY7Dy4=@vger.kernel.org
X-Gm-Message-State: AOJu0YznPD8fG+sku1cNz7RDep9gFYJfwRZN2zfI/i3ieX1K/INaLhvY
	aHyik6GLtturcogSC7YvjLFyXps9EIx7XSXtL4WPkc1jq3Ko8MAKR+G3nVnzI8+kOzM=
X-Gm-Gg: ASbGnctjLnGdiErUL1BYF0OXpj8d9GMRmtHE1IvVqXX1B7w5ajgd5ZMgJ9X2P0opsq4
	RQLB+miSkk9WABPN9h35us9Y63t7Mp9ryr6wDK0FoA4OAOn+2j2sfWkq+SybNjafWIQA+WwUKc0
	QAw26ZOucRKm+rtiXeXOXITTBg9i4LEImjWJDR952QoQ7TgLel9U/EfaXSK5ZiOxKQhtNmKN9Tt
	AqyI2uaptJD7HiMW4+YSVXOx5Xa9bFngQXJETq8ajTpZpKh6FA/zXImgGyvxvERH7H8MiVS32bY
	5tmBbKyoj+8IU1OAjQVFomA2T4YjWMsbJCA5UlNZm+s657Qs8fGJtSxDv5O85sMjaRJbKhssc0m
	UV5/nMJtgdWC9EIulGVBdgyfQijTLOs0wfhHiy0KUffbhTl429/WI6/sPiMGuDqy6
X-Google-Smtp-Source: AGHT+IEHIfW75N5y0R98OUlepL6okEPOBq4l5OxuL7bDpbGtJWWxEFFZctsR4HRbkhMXOYHJWxXZrg==
X-Received: by 2002:a05:6000:2305:b0:3e9:b7a5:5dc9 with SMTP id ffacd0b85a97d-4266e7d6bb2mr3037022f8f.23.1759959154071;
        Wed, 08 Oct 2025 14:32:34 -0700 (PDT)
Received: from asmirnov-G751JM.Home ([2a02:c7c:b28c:1f00:b672:801:34e2:2e5f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8f0170sm32585881f8f.49.2025.10.08.14.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 14:32:33 -0700 (PDT)
From: Aliaksandr Smirnou <asmirnou@pinefeat.co.uk>
To: conor@kernel.org
Cc: asmirnou@pinefeat.co.uk,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	hverkuil@xs4all.nl,
	jacopo.mondi@ideasonboard.com,
	krzk+dt@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	mchehab@kernel.org,
	robh@kernel.org
Subject: Re: [PATCH v6 1/2] dt-bindings: Pinefeat cef168 lens control board
Date: Wed,  8 Oct 2025 22:32:33 +0100
Message-Id: <20251008213233.8541-1-asmirnou@pinefeat.co.uk>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251008-pushiness-underwent-a1f0450a933f@spud>
References: <20251008-pushiness-underwent-a1f0450a933f@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 7 Oct 2025 21:47:29 +0100, Conor Dooley wrote:

> On Wed, Oct 08, 2025 at 06:50:36PM +0100, Aliaksandr Smirnou wrote:
> > On Tue, 7 Oct 2025 21:47:29 +0100, Conor Dooley wrote:
> > 
> > > I acked v5, any reason for not applying it?
> > > https://lore.kernel.org/all/20251007-geologic-epidemic-2f667f232cf6@spud/#t
> > 
> > Yes, the dt-bindings patch can be applied.
> > The v6 series does not change anything in the dt-bindings patch - only
> > another patch in the series was updated, so v6 was sent.
> > 
> > Apologies - I wasn't aware that an acked patch could be omitted from
> > the new revision.
> 
> No no, it's not that it should have been omitted - it's that you should
> have applied my ack on v5 when submitting your v6. I guess timing worked
> against you because I sent it like 20 mins before you sent v6.
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks for clarifying. I'll make sure to include your Acked-by tag in the
next version.

