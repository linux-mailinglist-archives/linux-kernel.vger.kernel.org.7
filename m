Return-Path: <linux-kernel+bounces-744844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1D5B11184
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 21:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99A7B16359F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 19:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81AED255F59;
	Thu, 24 Jul 2025 19:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ftgx5yqI"
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D832E1FB3
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 19:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753384700; cv=none; b=UQ1kRyaY8K2nFOla8gxThpL3N8Avqj7hDHGar19vXlFQU3GxfO5MGW2YEyz2HlwLQ836CxvSXOBBEhBmVcuZDTUFozVW1AM+nFMEoKDpN+O2sDKpAB10YlhVNxoIBIXDaBX31T1P+2NNRrJz50qPv3Lg1eDu9rNGA6iyD0sBMs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753384700; c=relaxed/simple;
	bh=GuZwGYLI+XKgX3g6bp48oh1cnV8nx+q7GNk1m3f+cv8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=QjI6/0mRNsJ+FW4KqO/7TxeNfPJzUnLMtEuobeDa/2r2ZPDFMI77yC1+HbslkNe2RBhwi4o0VPlzlG0dLmze8aq7qR9OYtm4SCh6DBq4go4JMjd3yuutLkg/qep1d02O1q3TyE7qzWApbJXB88u3yWDLS2+vCK48317Er0hHORQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ftgx5yqI; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-73e810dc03bso276443a34.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 12:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1753384698; x=1753989498; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/WtHerWg4b/PvYvoi1jOtoBEkjJBfw4DbZ1mKGQlK7E=;
        b=ftgx5yqIN18G1AGc1GysL2IrVCWXOsbbHTPCnPuLYa6K2QFTCLmtO2PTkeAcjBFDmU
         uOYZaWrNThU+3JlncyIRXcpuXzRhkO52Tlw2cUc8+6ZGuNc+8QSTNnBUYRQnbY4GHw77
         S7o3vMvvajCKvEZIuX1zG3dNIgtpimn3qwcno=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753384698; x=1753989498;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/WtHerWg4b/PvYvoi1jOtoBEkjJBfw4DbZ1mKGQlK7E=;
        b=nRzBhLNjWOu2nrt5zGOoeYjjPEZKoc572KAWu7eGl0e5ly1idbxyfizSGvI4PI5uDm
         riAvieW2y6quF3iRz31JF/SFK9FsPSfeGGDpZu2q9bniuDDSzKVwoegErCr63++il9OT
         oVYd6MMPToe6asgS2Jf4Vp5VJY+HFwRTFtFZUhtUmZTiiQEhPZjVDV6SrFiCRGLLcYD9
         yaSIqxR6O2IVwTyObSYv04kH13MdpTW9UUnvnNHjMnntl12q0oXQ4cfvSxZbJoIl7cHx
         4Gh5E4D/zzwq7FcbZESiPnj+q5yyLUNM2zwHtSJcQZBnGmUd/f8rC6NPvJdwO+4z6m6g
         ut9A==
X-Forwarded-Encrypted: i=1; AJvYcCX/FlW7tidYilJqmyMNg4IGkEx4oLH/HCrimIV39M9d83JwrjYtKyczkg7YAhHSJpPs4YDnLArYGY4aymY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6jNQP/944J7lOCX//zfHL2jLUir2uFOuopfNzmKOue3zNPHG+
	TUe9BY43zOkIwL7TqNRAU4Y/ig/Kb0gQZfeDJtw9XMEqMCuQA5mseCpKtc82buTHSVTF6Sbexpn
	lhb5x
X-Gm-Gg: ASbGncvHivHoVPE6OdmsC38GF62x0YEEH5FA9tBHIt3gfC7+OU0oWUX3LyMj2jHQxWM
	ycKdCVkp2kw1fyy/YMfL/XHAVN3NUIwxXyWBb6FpHoEjARbmoGVcCVrLHMHSdrFGEvNrv9hgiHR
	H3qXeqG4CEI0Ci6Nu+tN9t41Yc6zK0GnZj3mY6ldTxDOZd5rTjOQQZszegJ5m0PSjoz4k+yNVTr
	veU7Am8Cso9/kA+wkOmDH1RfGq5inVRxMyJ65RIpXI8akevAX89GmsmqrVEbP+VJ2/2zziS1+wu
	/e/UpuNIfduPF9vSGGlZplBs7Bc5rZ4qCiOQoS3VZBdV4TcPRVy0gWD8EhH0ll8VgGdxcrfLFzd
	VMTeXvnsC7uK0bwplltrQTJp8MOotXHNYFw==
X-Google-Smtp-Source: AGHT+IEUTT6232SQ1StpplGMujNfYLMj8RDUEQUykk/oyYKKyc7meHhp+AdRCjc0bN5C/ycM7Zqn2g==
X-Received: by 2002:a05:6830:6689:b0:727:345d:3b83 with SMTP id 46e09a7af769-74088ac4c3amr6082385a34.23.1753384697537;
        Thu, 24 Jul 2025 12:18:17 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7412d18d95fsm361195a34.21.2025.07.24.12.18.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 12:18:17 -0700 (PDT)
Message-ID: <ed6f49c8-d47c-4cf9-889a-76f6886e1a86@linuxfoundation.org>
Date: Thu, 24 Jul 2025 13:18:16 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Code of Conduct violation complaint
From: Shuah Khan <skhan@linuxfoundation.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: "conduct@kernel.org" <conduct@kernel.org>,
 kernel list <linux-kernel@vger.kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <13a6b8e3-a35a-425d-bafc-006e0a52599f@linuxfoundation.org>
 <aHanGu9nOGOegUg2@duo.ucw.cz>
 <878ca180-c54b-44cf-aa14-cf6028723167@linuxfoundation.org>
Content-Language: en-US
In-Reply-To: <878ca180-c54b-44cf-aa14-cf6028723167@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/17/25 10:32, Shuah Khan wrote:
  
> Hi Pavel,
> 
> The Code of Conduct Committee holds these conversation privately
> with the people involved. Looks like you cc'ed the mailing list.
> Respecting your choice, we can continue this conversation publicly.
> 
> Chose one or all of these threads to apologize to the developer
> directly.

If you haven't already done so, chose one or all of these
threads to apologize to the developer and cc code of conduct list.

> 
> https://lore.kernel.org/all/aG2B6UDvk2WB7RWx@duo.ucw.cz/
> https://lore.kernel.org/all/aG2ClcspT5ESNPGk@duo.ucw.cz/
> https://lore.kernel.org/all/aG2BjYoCUYUaLGsJ@duo.ucw.cz/
> 

thanks,
-- Shuah (On behalf of the Code of Conduct Committee)

