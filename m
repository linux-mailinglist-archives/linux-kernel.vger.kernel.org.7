Return-Path: <linux-kernel+bounces-871244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64271C0CBB8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 10:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D214140236C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460672F12B3;
	Mon, 27 Oct 2025 09:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P7iaH7qP"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B8E23BD1D
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 09:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761558024; cv=none; b=EMFO4/ruWRlQRr0OnaIzyqhAxRaMmvSWueaQk2F/PBPityMQtWkfYpAsr+UMX26UpNAfkfStoa0+v+fk7fTjYH6I36y7yZeDieM/0L9M7OwiH2GRmbjOsJUUpYKWodILU5YmcTAXK9UsRD1gD5bVvyJ+CXLcHnmd6vrR3xtBRnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761558024; c=relaxed/simple;
	bh=OBK/hlc3IhBJpXPcTuCdhYTqauXBw9jA6wbePkL5/aE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NLYmcouk4AOXMXmKxZsJZk47DJyTlBrcI9pyn9dB5qHj5apJbAtIoQ62mRhMsKT4SF3q4XGh6aMqzpseaSUCwqW71G82ulJIhdOD4ty9n3Y0ANyJ5ZcWu4Xry6yIvckp97PVT6HVlTvOdSYh0N5f+lmxQqPu5Lja9YbRrtFhTss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P7iaH7qP; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-339e71ccf48so5732512a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 02:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761558022; x=1762162822; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SZhBVqQ4OBoFRlZguHQ3+Rolge9D6o3ln7YwlfvJX/I=;
        b=P7iaH7qPKZkfVaRsEXo933cmTWOTJpqFojapEWSk+XcKdvMLVMEDTfilaeO+Bpw1Qf
         smUvKDVltcMXaGvdY//mjzlqW4El8i7jjXfLaJPdWP2xr5Zsm4vjod9ISsol0XLAOHeu
         X6Sx2F7kiEmdMCuGaDuCoqPgiIqbGd1xZ3oRs0l9F+OfbEPM2OP7ijSYdjGAmZb1Xzqo
         bf4hYmXQbaHbgm/HyBnzTbRP4LR9W8tvbAU6qIy32QCacSAAfccvT1iK1HY9SwBCZAoi
         i3+HzbmdLmoz4UXIeBSHxNTMtrrCWd1rbLelVs5VZvGrSKElIG94DCVsMBRASBdr9bQd
         IOwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761558022; x=1762162822;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SZhBVqQ4OBoFRlZguHQ3+Rolge9D6o3ln7YwlfvJX/I=;
        b=gHGKM2q3nNRUv2PwEAaGLQZtIF3Kmz3yfrMg0s5hYmvIsuXwmUHLRB1vrjhSCWI2PP
         x03pWWxOckTseb72wpE7FwcZp/MKprz4qgwg0GkJt6OicuNWS+WBVS4ejyxsr1832pnF
         7y8EUpAMTXnwf5VKuJjdopHyZGHlhpAjuhLcJ+1LAKSpdkcPl/zi93AqJhl/ssKU51j8
         76w0kQmlJKKWfSePQAlwzAgVw+yLDf8ASnpYc+YdDbHseHXJes0eM+3Rl/VjYhahu8e5
         DxBY4dYXn4VP0RMXZNsNdGZgULRAeqtimG0tiblkroNg+vwDWXM+OnqydHrBATDgEvKt
         N18w==
X-Forwarded-Encrypted: i=1; AJvYcCVIid0wZRKPf8sNrKhXqhiBfGaxZEpXhjplHi8Xb5biZRu6hqOh0JZgmZUp3wvMcePKZwbiIWX0aMfDj3c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn/QjtgbjbzaFPGJUYbLv+qh8CMZm+smoj8BQieY3yJlCwCFvI
	X/Doh0y1bnZmVlfOZs/y0nHhruTf/XFpJK7zOp1+a7DeoMChRnPQh8uzuaK87kqIDi8=
X-Gm-Gg: ASbGncuA0j/ML/KKcobQV87A5C2DS1niGpLfJoG+4J3d+ZG1F733I0eOX1UspoTCx5I
	eyGgCLlddZWAdsfjKeinw4X2fl954ir2CgHH/ZTHYpdMbATafhzLsXEmFImmVaVqyKlB8VSsVOF
	qgYFJGlXswKNfWl/JFony+utJBx5DjBPH5ZhEjjntK4nCmDrlfjEv4nb/aDvtyLJJyH0/iJStUB
	DQGoJcBLPrY54wIomlpimXKOlNhI2e/KJmiPoDSnDgZDNYDWQDwyb87rpZM7Ydo6bc3ypUsW0Ka
	7uNt8nOSwZDLSBdV6QFjsoZF+1LsY3ag1Ea5bgDLRfWRAGlDW/ai/7kc4ZByVtq0xZuHeqqhx7s
	raaB1raeJis08yemYrmILsz+u6KNBnva9MO/r6JT/enw9D9T0bJ7qq0WOQgr54w==
X-Google-Smtp-Source: AGHT+IH1lzON7y8FAZpNw0PHIHHwRPVZE8rQDV1gpMfPb9o5k0miwVYUfPby0HNCF5HieZEKoNhNig==
X-Received: by 2002:a17:90b:28c4:b0:32e:d649:f98c with SMTP id 98e67ed59e1d1-33bcf85d5a8mr45413074a91.1.1761558021739;
        Mon, 27 Oct 2025 02:40:21 -0700 (PDT)
Received: from CNSZTL-PC.lan ([2401:b60:5:2::a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed81aa87sm7800126a91.20.2025.10.27.02.40.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 02:40:21 -0700 (PDT)
Message-ID: <b7850571-4e9a-4b9f-9776-8c7521b84549@gmail.com>
Date: Mon, 27 Oct 2025 17:40:13 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: phy: motorcomm: Add support for PHY LEDs on YT8531
To: Andrew Lunn <andrew@lunn.ch>
Cc: Frank Sae <Frank.Sae@motor-comm.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jijie Shao <shaojijie@huawei.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251026133652.1288732-1-cnsztl@gmail.com>
 <70e72da6-9f07-457a-9e0f-c5570ab6fe9c@lunn.ch>
From: Tianling Shen <cnsztl@gmail.com>
In-Reply-To: <70e72da6-9f07-457a-9e0f-c5570ab6fe9c@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew,

On 2025/10/27 10:10, Andrew Lunn wrote:
> On Sun, Oct 26, 2025 at 09:36:52PM +0800, Tianling Shen wrote:
>> The LED registers on YT8531 are exactly same as YT8521, so simply
>> reuse yt8521_led_hw_* functions.
>>
>> Tested on OrangePi R1 Plus LTS and Zero3.
> 
> In future, please could you put the tree name into the subject.
> See:
> 
> https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html
>   

Sorry I missed this. This is my first time sending patches to netdev, I 
will follow the instructions next time.
Thank you for the information!

Thanks,
Tianling.

>> Signed-off-by: Tianling Shen <cnsztl@gmail.com>
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> 
>      Andrew


