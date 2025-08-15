Return-Path: <linux-kernel+bounces-771420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6936B286EA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 22:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AC79AE77D2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 20:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274092C08CB;
	Fri, 15 Aug 2025 20:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ancCptUe"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E022BE7C3
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 20:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755288251; cv=none; b=rkgOU1vbbazZz01mQNhIkxhTfPRZhzIMfsOTm0Vt07vOqFyE3U6FuZEvsWoeuCXm2raIXKS4fsY8w3VdgGyHZvkp0oLsYePForzHoqseTInW7tWNuvd+AwCgJ+Pk9m7l3Dba0touyKDeDOE7iNIlm+QO3Nk2qwzxDCvSlJ44jZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755288251; c=relaxed/simple;
	bh=AYbiIeF6iptLsGoDj6CX8UYKKLMHp5WQuDxStj51bMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nlpMle7Aj+h4BDmaUMuYeF09WMkFOXcG3Da0r2PSK6ol/RZzWbLLRp4dINxeR0YYLY4maTIfZj3clmQNhSYvlPvgbwFhtrY9fBH+xdxZ+RXU+mCUNVgkZa84vM+DHg/Cxj6C6kHNtOt7/Ys4DT8gw+NHupYuTxiFliUHqqXH/7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ancCptUe; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3b9edf4cf6cso2094352f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 13:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755288248; x=1755893048; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/dVp3c/mL+kWmyAxnHEJ2Rjfw36Df5+7d/WFZD+6RK8=;
        b=ancCptUeDTVMs75AWKFX91fKsRYKtP4j/9K9C+OD+IliLIrizIB8KmddZXY5+UjJzT
         T0uE0w3otjfY+JdIkY8kSONQ/CMnHvEQofpjXljuCVwBpm7RghqjRhIGY86W/KylFpsM
         Hp0reFIZ+FBEY3wMhdl6B45goL1V9Soib+MVtu108VOSi7bnFlSvtR+a74SuvxGvfwEw
         PBV9OyTydwamgfhe9dEbQ9uyZ41hBRGjy3lxmxSaeLqMC8FnPEKwDAffvtyAYRqaBW6r
         f+RAvKSrj6wR/xTpZs91zE97g5rompNZ5OL3DkHW664C06sCeY10jy1z14vCjnEPEA8B
         owdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755288248; x=1755893048;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/dVp3c/mL+kWmyAxnHEJ2Rjfw36Df5+7d/WFZD+6RK8=;
        b=LBWBMW67+G/Wr6zycHJSiayfZ8rBh/HbLmLC53+N7XYgNkPoH4zdFgejvWqBcQr4ry
         PSosoWCDsoIFugN0I+65vtlwTx/YvbA2X5nRlVkPmbEVzfUuIdYDz+DJFRqeV2/SNq6f
         gjNokK4e+V5ZE+n1NfPoqM5zAkkCVzsKlQfUbs2Qsb+T+CIju+SJ2LPgwjL+mz1pgIRp
         8Dxv1w1cdlE7sgw7aQJVORcx4icmZ5GZRcM93DyWRj4UiO6wPcoqlK34VJ1kTcHZQdoB
         aQmQcbAv3d+1/9CFzGoRqLHLQ9XiDrJrES9kyGQoF7+7dzhCt4X1/hLhMQNOhEgHfUou
         DsWw==
X-Forwarded-Encrypted: i=1; AJvYcCX8S2RiTfFYo3pEEuTVnzj0HoWAAQxpsjPu83R2taq2sc+9ZtF7z8HfiSUEnO4291HZylTdAtunFz5pp0c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeaAG6GxZ/dRAcemCEMvgWt+6kXgUK9QN2lnStEAidDuh0euQL
	Iato1Qo10huWNkganwG+2zGgamnMXDbxGCrDIZwJPtSdoolU3ff75cFPODI3GJZkED8=
X-Gm-Gg: ASbGnctZyxOPNZ44X36Gqb9PFriXWwcQ3UQ+uDEQi7zwkG9Fv2UBfP5sf606Cf0O1zT
	v9+4txZa+dKHfMACW5eqSw4G+NlDiYL9tx8ip/+IF2iCoDYo+tBLIMvRjoODcJPLt8a6dZ49MDx
	0ocdXmtOJzxlfgFnVJyeBtVmCgSSa8NKx+tUq1LHPMV8OuZTsm3UuB9UMVIMcGnSgsHIlNuibOK
	kWjSv2gkgPM2fb1+ZFdl5jY1Oktdk3EWwM+YscGvl0xrRibmbalGbB5EEijHwlLOmdHKbGT17cD
	Ao9EoADGvkD6T3DCVvqnNMTAdgaMTsLHvYtKKHmEise9/5oApmJrOkoT71SxeV3WO2PClMV+80P
	K6oKeSYFNaZVCF5ghYPXiO3UQO6s=
X-Google-Smtp-Source: AGHT+IFeT3WqPGdZuR7vMkj7YvcRJntIuG00A/c4v4eSx+o5nUwQFOtRCUjiC2QXYMDK3VHtd0TfNQ==
X-Received: by 2002:a5d:5f91:0:b0:3b7:8146:4642 with SMTP id ffacd0b85a97d-3bb670ffc24mr2519110f8f.20.1755288248212;
        Fri, 15 Aug 2025 13:04:08 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3bb680798dcsm3060951f8f.54.2025.08.15.13.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 13:04:07 -0700 (PDT)
Date: Fri, 15 Aug 2025 23:04:04 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Abdelrahman Fekry <abdelrahmanfekry375@gmail.com>
Cc: hansg@kernel.org, mchehab@kernel.org, sakari.ailus@linux.intel.com,
	andy@kernel.org, gregkh@linuxfoundation.org,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org, Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2] media: atomisp: Add lock asserts for mutex protection
Message-ID: <aJ-StLSBnHmHHGUX@stanley.mountain>
References: <20250815182411.36092-1-abdelrahmanfekry375@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815182411.36092-1-abdelrahmanfekry375@gmail.com>

On Fri, Aug 15, 2025 at 09:24:11PM +0300, Abdelrahman Fekry wrote:
> Add lockdep_assert_held(&isp->mutex) to critical functions accessing
> shared device state. This enforces proper locking and detects violations.
> 
> Suggested-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Abdelrahman Fekry <abdelrahmanfekry375@gmail.com>
> 
> ---
> v2:
> - Fix Typos
> - tested by building the driver
> 
> v1: https://lore.kernel.org/all/20250815170901.32105-1-abdelrahmanfekry375@gmail.com/

Same comments.  Best to wait a day between resends.

regards,
dan carpenter


