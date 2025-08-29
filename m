Return-Path: <linux-kernel+bounces-791279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9435B3B48C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 09:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14EB11C83464
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 07:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81C927AC21;
	Fri, 29 Aug 2025 07:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G4p/Uwuk"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F111C275B1B
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 07:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756453322; cv=none; b=O4KD/cELngFyHjamPz1lTeTi2WLo4EvlIbPo7jZYNfcurRF6KDZCKdQcA2Z4AQPy7pOVa0vV/2zh8Hor8rAuXpl1HpErccpd7ZwFReAmNlMJ/yx2wmTUSnru0Liu6YtDiHG9URArnCkp8QzWZHA1jJqNd23KDqTQ3ki9iayLggw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756453322; c=relaxed/simple;
	bh=knOwTdhp1w71JACd9L7vianR106YfJXB591UpbwL2nY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y0cqAZyYrJdnMp/d4PBQL4mIG0DbrvS8JxUVbFXLEhTpna2ErTQ+xZco4zI70zrC2v5m8PNKFeMEBTM2av7naIpWZ0HT2z9LIJ3cBbZH+kyN83DEyiu9p72PmY7GD3oGpHvK6D0mhbdH5/1M5Yd0cb7A5n4DNvSYGoJIQd1vQO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G4p/Uwuk; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b475dfb4f42so1288135a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 00:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756453319; x=1757058119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=knOwTdhp1w71JACd9L7vianR106YfJXB591UpbwL2nY=;
        b=G4p/UwukEyldIQg2YYha/zQ2wQZlHT/NNQft+eOty3jGx5mQHRFy/Pz4+gWYLggtFA
         pkY0FtPsnXoB91POJNosGl2F7XWu6ln7mpY+DKFBk8OAhiEPNBpOpMA+h+U5cmnTbEWb
         l0is/SMnOrmblgYpy5wbl/NF5p/oKeotYZIrs1agXjSSmILnVzLwZUYOnC2nRI6dQ0dr
         o9piNNw7vaHvBFSKpECU6jMcUo4cyKqdubj2INLb1fvzd7s/O2IdijFFkYzx8DkLrjrw
         8aHesg+HpNzbpIKqFdLVOjeWEvWBYIpU3e+5gYw+vhBV0TLr46LprDftuUacil+xHHIC
         Y9Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756453319; x=1757058119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=knOwTdhp1w71JACd9L7vianR106YfJXB591UpbwL2nY=;
        b=JcdcMy4htP03vl1Mme2LBtcVrxXX1JdzwM8cf0EMQAjn1wiQvl3JgT377apcM2X1O4
         Xm1kc8cZrnFsUk/UPje6Kili5HZAAFSQe1qCljlK9YHt+5H80cwoqMccGlDHG2NlsMec
         fCH2/Hjk6lxXAMkFI5ye4n8jvzWNJp698dqlheoOTlLGdnLO8KCwnrw5KSaynEa2c1s4
         zhgZ/TRf71JmV+IedJxF6n6gm2YauKBmQPNwWiKGa1hyLPeUb+mBppleCCfcVtJluY0E
         N5SabFXZJowD7NLSadnDNrMOJog4rCVI88wmRwtcVtl2kfc/8u51//7JdVoiAd85GLBd
         edNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqt6YTbN2v3tlnXkz8bLLSlNZDqP18Qpcc3cmrPAQgaKoBxV64A81pgbLajWr/yt+JtQlzXCjcT5tJrpg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTbbxamxgUnw66WcKqiLriMd3PmbGOP/FZBd54r8vfKPI+7jNr
	2nCbZYjdGDyktRYDpr8bNgIYxKVWBpMKXTm8QGicyVmo7+Qf1TRIn9R09yf9JCt0d1g=
X-Gm-Gg: ASbGncs0TKEDhWMG43g10ucTVsc6SLWtOJ+3LLCuYSdxeRNhI6xMVP3B2AgI2nISHAb
	v2scKdHcUH22HSlHuLq2B+CCzZU1pQNTjCs1QFhQO6Foe56gaNO7CdZ9xIJ7F04JFSvYG7ejVLq
	Vt8/mtyFWp1fMS1JTXOzMr0acIPNAlhl1ytb3onMzw8Vw372reOqC7XE2PvHSqlAsEqFmqbjTVS
	3FTdcwaDK4xuf4iMHIs8SrH5L1buob3aCIyaNjouYUtCsaXJHD8j7hGVQ6GCzHMse+cwQBLUEuH
	o+TYuBRF7xdPgITZN434ESZZjsYgaIoNZXQGrIYCUKVZuIdDSpeVyYsWdFaCTKqBsxiC6nfhUOf
	+9lFWmTXdnxNILk3pBMGhvRC0a+alDQ==
X-Google-Smtp-Source: AGHT+IETAkMl/+/yPU+PyfRIWy19cUVq/UQ3leWcZvK0ONU/TNvkUzax0K+V6T4TRMooRP7D0B6SNg==
X-Received: by 2002:a17:902:ce0b:b0:248:9c98:2cf4 with SMTP id d9443c01a7336-2489c982ed7mr129967845ad.46.1756453319511;
        Fri, 29 Aug 2025 00:41:59 -0700 (PDT)
Received: from localhost ([2405:201:c00c:2854:f8d7:f98b:c2ca:420e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-249037285b9sm16627095ad.44.2025.08.29.00.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 00:41:58 -0700 (PDT)
From: Naresh Kamboju <naresh.kamboju@linaro.org>
To: inochiama@gmail.com
Cc: anders.roxell@linaro.org,
	bhelgaas@google.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	lkft@linaro.org,
	looong.bin@gmail.com,
	lpieralisi@kernel.org,
	maz@kernel.org,
	nathan@kernel.org,
	shradhagupta@linux.microsoft.com,
	tglx@linutronix.de
Subject: [PATCH] PCI/MSI: Check MSI_FLAG_PCI_MSI_MASK_PARENT in cond_[startup|shutdown]_parent()
Date: Fri, 29 Aug 2025 13:11:51 +0530
Message-ID: <20250829074152.337221-1-naresh.kamboju@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827062911.203106-1-inochiama@gmail.com>
References: <20250827062911.203106-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 27 Aug 2025 at 06:17, Nathan Chancellor <nathan@kernel.org> wrote:
>
> On Wed, Aug 27, 2025 at 07:28:46AM +0800, Inochi Amaoto wrote:
> > OK, I guess I know why: I have missed one condition for startup.
> >
> > Could you test the following patch? If worked, I will send it as
> > a fix.
>
> Yes, that appears to resolve the issue on one system. I cannot test the
> other at the moment since it is under load.

I have built on top of Linux next-20250826 tag and the qemu-arm64 boot test
pass and LTP smoke test also pass.

>
> Tested-by: Nathan Chancellor <nathan@kernel.org>

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

--
Linaro LKFT
https://lkft.linaro.org

