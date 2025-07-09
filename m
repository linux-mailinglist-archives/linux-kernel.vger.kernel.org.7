Return-Path: <linux-kernel+bounces-724322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE894AFF154
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 21:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44DA47B33DD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 19:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2DF23E25B;
	Wed,  9 Jul 2025 19:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KupB1HkK"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D7823BCEC;
	Wed,  9 Jul 2025 19:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752087759; cv=none; b=ke6qEISOLrxADwQ36G5BHxbPqzGx49YtxISqlbFWC3xrHxGe3YXtkTN+HToo7qFmop/mL0hUmNJSRjZhxcrjen1NBGRZPhYshpWr0awL0UfHuLTkVcpNXSlvQuOs+AoswRzwgFMB0rPbZa4N81cC5GIox3I98YbWdBFecCJTJqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752087759; c=relaxed/simple;
	bh=+3sRZYxKu9ZNnoJogkN21rQyo+O0Se4oeCkfjxa6+Ao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NNbFYsKgdDJYRTKWc1gufYKO84oQ6AEQlbzLh2Z8pdDLjLObtIcT77bpGMUMzgh083BReBb0rn5T7xW/JTkenexIhUdE3kPH7RBX+AJMHXQ+kDFYE4f5qxaNUasLTNZ07fd7aXxOOrk2NsAWaqbpGigqFDx2Bh1olg5/rXA63iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KupB1HkK; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-553b6a349ccso211102e87.0;
        Wed, 09 Jul 2025 12:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752087755; x=1752692555; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ojbQIQKHeO4kPAy9M7zl7XDn7zT8pQ6K2ZFdO2sJxZg=;
        b=KupB1HkKvucxuENRnqQmWM4HczojXPGkzI2Up2ip9W8HoBtCau0y2at/lhtaCFz6Jw
         HXftwdkJ3Lg89Ipn9/CYpnXwFB7T7D1qD5i+jDdnSKswSpk4xnv7sa2mZZ3BM5cvEa+r
         ECSlOqO+Y8sKCK0FotRUw3eoosTSXbQnBQGKce2Pd00h45346sG7RPriF34fWMn7goFe
         8TP0Sgk+Zic69TcOPganKD5Ipjn+HtbX4cLzAh+ZP2Iix00uxVPU6tpfBYXoQXHFetYP
         hnRmUEQBRFVeetEx0oyBNa81RaEj087dLytMeE3x3xwcYZEWV6Zr3kw++5SRIbu0PRYS
         cN7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752087755; x=1752692555;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ojbQIQKHeO4kPAy9M7zl7XDn7zT8pQ6K2ZFdO2sJxZg=;
        b=pnQ+oc1mEQ8jePtQcJY0wc6g+qp9RV6aSZa1+FjgkfFqWROD56oFRJIpVxSSi++Q4f
         yl6KecGs1BqTEezhK8eEMwl9+CSF28wvud18Y4rmP6NhTrtHPBE9FdrMh6hKQLSiKmYP
         bQjR5pdAQwGvfzBYkvbRXJNNdub5USuRdlXHRMBo6v7DbpDjGvYqJnP9NeBCjYLkY76i
         P4EvtNYqiKIrjJWczOZNC3jE315EW/+2NuvCX7RBTQ9hpFhz2QobBhKXA0EaK2ao1ulJ
         3qe5q94aV+/hB09AYm9T1Bz9o+egEvr21yvQ/q6HOwf/lzVx4dA1C2hk2VU+pOSuzmrH
         g4iw==
X-Forwarded-Encrypted: i=1; AJvYcCV34/jZH6LJtQlGzujm0ysS3IGEeJfyptMaZPKCbjnjHMry6zBXkPVur6HmPQNK5HhspeceGxoAPkEQf7I=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp5ySszDr9tl3qt7i1Pk2QpCrYCHcZorji/j4v0Op93fgcw8Zt
	XwHSBVaDZ/qN8k3lw9vM8kI5vJIk1LVlw1ihyuhCYnEwcEuP3YoB6omi35aoHw==
X-Gm-Gg: ASbGncudlRb2OPTjzZCih8nWzbViYOzu1yWxB6UA0eSyVD33hJOv0RAUTzbAlSP95Vp
	f6C9IFD1YuCmdspyh04uFcWRv9FP9Wh4vcrMF+3Qr5uo8/My3NpFUo57DtjaEtjQ75noa5UhMMw
	9npB5NVS0SGFq4n1CMbBnjJqyR5yLOnpd3TwcDKJL7dKSm4qepTPEHuYS1VMigkKN6fiSeMDpCn
	RKXtQqaeuFawud8ijAS4t0NZQuq46FtYGlan3sKnxxOhhc1TMM3u+AIpgwMRXrAWT0CiqvZubZx
	HcxCPBj9/RkV7Oj6qo+wQtuLhvCtA8N+j7hsc+sz3It5MwLlX3syu72OTaqlWKIiFxZSQZONmkD
	ibPoH7yA/roaPcMXsULoTiaBicPeS06ispDK3+Uv5
X-Google-Smtp-Source: AGHT+IFogMXTJ4Rxvie5mGMCLoc8gUjVrKL0UNqdMw/Z/G5XKc5zd7wA//Sg0lLcXt+yibUDSgWoJA==
X-Received: by 2002:a05:6512:31d0:b0:553:296b:a62 with SMTP id 2adb3069b0e04-55900028e60mr386297e87.12.1752087754677;
        Wed, 09 Jul 2025 12:02:34 -0700 (PDT)
Received: from ?IPV6:2a00:1fa0:46b3:2e4:30c8:7493:4f02:cd4c? ([2a00:1fa0:46b3:2e4:30c8:7493:4f02:cd4c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32e1af83038sm19718701fa.14.2025.07.09.12.02.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jul 2025 12:02:34 -0700 (PDT)
Message-ID: <1f827061-d2f1-451b-952d-3d1631d7c9a9@gmail.com>
Date: Wed, 9 Jul 2025 22:02:28 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: gadget: configfs: Fix OOB read on empty string write
To: Xinyu Liu <1171169449@qq.com>, gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 katieeliu@tencent.com, security@tencent.com
References: <tencent_B1C9481688D0E95E7362AB2E999DE8048207@qq.com>
 <e1ef050c-9679-4571-a4dc-581bf005dab7@gmail.com>
 <tencent_7181918110AAD331E6775691326AD1000408@qq.com>
Content-Language: en-US
From: Sergey Shtylyov <sergei.shtylyov@gmail.com>
In-Reply-To: <tencent_7181918110AAD331E6775691326AD1000408@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/9/25 1:22 PM, Xinyu Liu wrote:
[...]

> You are right, removing the blank line is inappropriate.

   Empty lines separating declarations from the other statements should be kept...

> I’ve double-checked the original code and confirmed there are no invisible spaces or tabs,

   I'm not seeing them as well in your patch...

> yet checkpatch.pl still reports "ERROR: trailing whitespace" on these lines. I removed the empty line here, and it resolved the error.

   Hm... something wrong with your setup, I guess...

> Thanks for pointing this out!

[...]
MBR, Sergey


