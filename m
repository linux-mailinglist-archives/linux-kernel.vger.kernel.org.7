Return-Path: <linux-kernel+bounces-743708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F21B1022A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 09:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C77A0189CA70
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 07:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A794227EA4;
	Thu, 24 Jul 2025 07:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NLQ4F0Gy"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B0418B12
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 07:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753343267; cv=none; b=DN9RipHixezDVdEPW0suQt+bgqpHMdkMWsA7fhDIlxYgyEWoc0g0zERmZPy9TjGJOykatz9D1m2vh7dct11rTvjCSVOB+5eF7ObSb0Z98QRsWHKKTooK4P5DWa5QCBU+rNqi68bdNLXUN+WUiDu5vHTJKRmNNZ7wCFjptQz2EUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753343267; c=relaxed/simple;
	bh=GkZlzMsbwC9NT9A0zr+vZfjTAZdKR7nPqVFGiO0aDRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SYh3wjIItzvOtBd+Xbm4iRixjYimfUk8XIdBYkVUHXGpBvL+nxnnQUt4iWx5arCa2KChzNYzg31j2lod7GYOcMXf5aqfAbPGUZ6qyVi+MlHSYQ/Gx4AWYX0WrWHRj+v4AC0Rc4ejyQtKIM0kUGDbDjJ5z/jKhOQwt1eW6984oNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NLQ4F0Gy; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-607cf70b00aso1418150a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 00:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753343263; x=1753948063; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BCsHGBvSyrUsLsBAqIRdWHViyxCBqekwJoXqBFYbpq4=;
        b=NLQ4F0GyGE/Z3lhtFN1g4098p75UQi5NWkYAs09ZPc61C5l5A5ms7zPiU5OJOgR2DN
         adlsmqPDcF6be7+BdLrmhZy8B99jUVRDSs9XhxAhSM/o7xtBokS0X5ciYf+/W6DBBCrK
         UQTENyqEcvHGFF8zYUZG6Zpx3QWBeJAOMAe9OcFVw5qxRTuKpXt5QcQxLVSUnDXZabi/
         8pVsvOh7OPhU8ouNeN1uEn8P8V7BE359hOCzpzIY8Ui8ANpXYFarotuSUldTuQAC+OTM
         kn0GNoi/HVNb18mWUsA3VacocGXE2chlvOR0JkoNp/BGtuTHNvLPtt9vsRUn35IC7FV7
         HlBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753343264; x=1753948064;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BCsHGBvSyrUsLsBAqIRdWHViyxCBqekwJoXqBFYbpq4=;
        b=AWiJVO+iIbGrcGyArUI/1iU5MTcU5P6lztsYeMsbBvdoPcjaXGXbFY1rzPKDPSSP2p
         Xweerl5XbkzmgwRU1hkPDGptJ+hUkilpzcIFXlPxqbSm45D0yLEHwDetXsmV7zn73b+X
         zwtFqzJz+PoDGx5UODbF9w2vd4MYiho6VDHf9ydagnvAmlPqFWZd0YMkHjA/QiGsQdRc
         vlo/k+VctffwMzFIyIE7hi+Kv+rzm/ttysp3LjvH6HRa4dskZpLbjy8Bb/SeoIrmm/cj
         CH5KEHnzFqPPD0pf647RqdZax39fBs43tl8M+Nx3LCIYJ2pskWnMT0GL9/IZKu3DUDCl
         QN9g==
X-Forwarded-Encrypted: i=1; AJvYcCXpDREiUTtHTSuipIgvq28zAEYnXD71VOicOs/lqWP47d/qnZqJfGXVOCVnZ+XqSPEmVuhKp1ZSmhwD1rA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgM2Rr+5lHCXoQtwsGKxzjvw3lMYp2cItx/Ctrq73ubnIdjiiI
	cQeVhh27BvQ7h4Wjt9nNNiTHWGwwgTgP7kD5n/3minVi7QZy75ULYJEyBydGldARnlQ=
X-Gm-Gg: ASbGncvV4w4i2lnY8DifpdoV8e83/AG1g0P0OW4ipDT4LHU/t0b5IGUp/DhVHa4M33B
	WOQUys1RRzdOFlgfKg0UvyTaoyb+wq9d7cw6Ji/XDxE7/5Q5wHpEpfGTm+B6xZ8VM5tjSwOli5O
	GFPFYtYX60VvpDM3ptKeX6f7CpfLKj7+3I6oeUo0to484aB7yb/w1VT4Fz5H6+5qoA7k7PnMyne
	Gg55foQI9TYdVqzNNlzBS9okF29gmuD6o7mdstjeSDkQcg6D16hlIJ/Mcto6QVJ7ioVFbG34yxj
	CiWi9ync0cvlG3gMuxA1AjhhSUx//tHyq8vX7xPt/TjVtIGva79RHijTRJqWsA0Z/TnNwkxISpo
	eGGzAWJ+o3CKhwtE0cG/ScQaAEg/NGyJTlQ==
X-Google-Smtp-Source: AGHT+IEhhV27yTiJ5gFBxDikiEPBXQLvhGeDpwVDGw+Zc0stcC9d5cV/zCr60GkDvp8aoPbA1HE8EQ==
X-Received: by 2002:a05:6402:42c9:b0:612:a996:5cfe with SMTP id 4fb4d7f45d1cf-6149b5b01d5mr4946103a12.31.1753343263494;
        Thu, 24 Jul 2025 00:47:43 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff21:ef30:706f:1fb4:134c:465d])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-614cd31abd2sm480951a12.56.2025.07.24.00.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 00:47:43 -0700 (PDT)
Date: Thu, 24 Jul 2025 09:47:41 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: srinivas.kandagatla@oss.qualcomm.com, andersson@kernel.org,
	konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, cros-qcom-dts-watchers@chromium.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 20/23] arm64: dts: qcom: sm8450: add sound prefix for wsa2
Message-ID: <aIHlHZiy0ArPwSMg@linaro.org>
References: <20250723222737.35561-1-srinivas.kandagatla@oss.qualcomm.com>
 <20250723222737.35561-21-srinivas.kandagatla@oss.qualcomm.com>
 <g5ymyqh5soso5fj5mzdssz4ovqovecmvja4lvcgnfncnsvep3l@qsip7x3l5err>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <g5ymyqh5soso5fj5mzdssz4ovqovecmvja4lvcgnfncnsvep3l@qsip7x3l5err>

On Thu, Jul 24, 2025 at 01:44:09AM +0300, Dmitry Baryshkov wrote:
> On Wed, Jul 23, 2025 at 11:27:34PM +0100, srinivas.kandagatla@oss.qualcomm.com wrote:
> > From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> > 
> > WSA and WSA2 are two instances of WSA codec macro, this can lead
> > dupicate dapm widgets and mixers resulting in failing to probe
> > soundcard if both of these instances are part of the dai-link.
> > 
> > Correct way to address this is to add sound-name-prefix to WSA2
> > instances to avoid such confilcting mixers and dapm widgets.
> 
> This looks like a fix for an issue. Please mark it accordinggly and move
> towards the start of the series.
> 

It doesn't really have anything to do with the rest of the series at
all, so those should be ideally sent as a separate series. They can be
picked up much easier compared to the large refactoring of the other
patches.

Thanks,
Stephan

