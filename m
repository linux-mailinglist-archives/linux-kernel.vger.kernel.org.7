Return-Path: <linux-kernel+bounces-808141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC7CB4FABE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 14:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33D223457D1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 12:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0633334368;
	Tue,  9 Sep 2025 12:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UUEUDF/9"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708E0258CDC;
	Tue,  9 Sep 2025 12:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757420757; cv=none; b=D2a2M1k8f1LPTOQeyjOiW5rDzIE7dBl0oNySkAXujS5p/gwm1zxva7Q8Id621LvZ4oP6qynYO5aXupGQR87eDts5k2nOhtoPsT4FJYyV5BAo9KayWBiX7wnhOXC/MatAc57kG+2WFGZgwGNbMrrC7LjHmTaiYfJ7uwhm4hPZkqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757420757; c=relaxed/simple;
	bh=SNdGNyWh7kfEGKcOhsoNoL3IUtByr8pXyLVobokUrgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uiDML45LhYU+f9pf6p7tXbhOVd2VUUOurD43YeCXdx+guHdTlYJ6gPQpfueRYx82yrTYrczRvvV4QDDnx9HN2iG9FFwKywqu4I4LyoaQx39GiYLCRxfsgfsX1EsO5M/dUjTwhCd/TyIqBSc01kk+JxS/B6/YQIlB0K59je+IgtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UUEUDF/9; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-24458272c00so62796045ad.3;
        Tue, 09 Sep 2025 05:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757420755; x=1758025555; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wo5WqI55ESBi7gI3oZgXmx452TCDsTLZ+NeN6clGyvI=;
        b=UUEUDF/9ptrLpr6mTCyTm6hwzMX94CrGAEIewVonlaoNQy0PTSAv6q4rMqym9HtI5o
         j4QnZHLdlvRMV9bdHM3jWbZEvnqWbh/N7Dm0SL9PXDWloxGx5LKiqsXT8mYYr2OThRGJ
         W8OV+pcVy85FuB4WYkzr+fYbP1GBQxnuEIG4GvZNspYvWTMHQOEsbgq4IwvrCtt76N3O
         ksjlb4g60lj3IV17LZ/4GhxtBAIt4ortP7vnXsI2YZm2GDHHn7olPGZ4JQVkkrV1mEmh
         CMKJqBVJDB6mA1NzqJS9p6KgT95f3nIjgoZkr/P4lzh45HMwuOZbLVSYEJwMPGCP26Os
         rwQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757420755; x=1758025555;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wo5WqI55ESBi7gI3oZgXmx452TCDsTLZ+NeN6clGyvI=;
        b=IN8JxVw76sSiZ1bmcVDVEmS24V/41z37x8EssIamyWLhN7s66NRDc+sOoayttdmAec
         2E1U27Yht6rH1weGmhY9Gdn19RPNcWo8AQJ3e0KFSKgQtER8kJ8tU2qQKc1JDOiJUOry
         1dHFFG+E++DOCLUcEXfBvjYOgse/hOuko6/w89W8pHin0bssXMHT5izXzOqIBJENXwF2
         Jzs1Ng4Q64k3wgh8wVatvI7DH8UP9mKuARQvpNKOcXkb9L962US5BaYMo7ZfH0sizQkV
         kcs9rwIySCmyC7eag9BmNWre3VEeD79hX5HWK4dFjAvegVVWW/kGNCY9eoBomQdenM3/
         YXVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfjeN718iyyxoNdtkOwcxOY7KEkwC5swSSb4bbjtgYyhhvtedEzHHjAgrXkDCyReeKTWBonKKbI6kT+aI=@vger.kernel.org, AJvYcCUgryKW+8NldImhUxjrEHm7swqFDHltBtj/UO3EiaF7AYTntkIWbgqnkNaybrf9jY6VlxsJQG60Yh1v@vger.kernel.org, AJvYcCUqLS7NDLPxpU4ExTBerJF2l9KJ745thZmsQAWBpO0hf9Gq6gyrDLaANsBHnvBPyk2xoZQlw6qxQ6RjXpAg@vger.kernel.org, AJvYcCVobqmz8z++qTM3+XW+qufotp3RDUqX0tebdB7glsc1w8bfM3w1cSO3TNNBs1GtLM2NrxZIsGSJMOb9@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo+vZf4trjj7PhybIQOCgSREDFCwwNUkUqbPIsIbz0jrBgPBXG
	YpREmPlzL1428uP28oQ79xgGHy/EL4oIRMEDMhgVWUzy2sYEh/23gjFn
X-Gm-Gg: ASbGncvL0fnBbfU7H4JiAmavNaTB+nX06zlsy54avr8BCGBT+dXqu8zL912bMuylA23
	Fz6kZopYD2yCGwH/h9rHZ4WoiGyoYivCzkPjR6LxU+M/XOSpJjsxV67JIviBda3X4euD7lazKhG
	HZCPo81JUdFA/YhJohklX8pxQgHAeCHY1Isyr7DI+UgcKkqFQR9LnkmpEN07Mz28M+2aXRjqJvQ
	2ruTVF0c+CWWXQQxgEQu2a8aOIk2aZU2xY2MAx9LyUN/8XuoRgXl0Yp7zc2pKUhuSa07Ic9G2vD
	sk1GC8gOBkqkdbZB90LdIJy3xbJ/+cHZJz1dltaB2Nkp/Iz05Jju3X1L5O99QNsHr2TN/d5ON1L
	7BZinrFuqA78yJGUk0KIChHcG9ygYSqK2M86zq8+5tOEtLQ==
X-Google-Smtp-Source: AGHT+IHJs/MEPuIo3jzVF/OWKOd4P8099tRniR/rHouNz9fNcABxouo0ssy0F/yBSff3+LaHG4xFdw==
X-Received: by 2002:a17:902:ea03:b0:24a:ceea:b96f with SMTP id d9443c01a7336-2516ec6e834mr156519765ad.24.1757420754653;
        Tue, 09 Sep 2025 05:25:54 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24cb28e33d7sm155915035ad.89.2025.09.09.05.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 05:25:54 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 9 Sep 2025 05:25:52 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Kurt Borja <kuurtb@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4 3/4] dt-bindings: trivial-devices: Add sht2x sensors
Message-ID: <58e111ea-508c-4042-9ae4-d4293871e73f@roeck-us.net>
References: <20250908-sht2x-v4-0-bc15f68af7de@gmail.com>
 <20250908-sht2x-v4-3-bc15f68af7de@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908-sht2x-v4-3-bc15f68af7de@gmail.com>

On Mon, Sep 08, 2025 at 10:54:51AM -0500, Kurt Borja wrote:
> Add sensirion,sht2x trivial sensors.
> 
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied.

Guenter

