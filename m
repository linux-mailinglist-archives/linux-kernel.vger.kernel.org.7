Return-Path: <linux-kernel+bounces-878551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77908C20F90
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 142053AD3CC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9823363B85;
	Thu, 30 Oct 2025 15:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eBWSXKRY"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FAB30506A
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 15:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761838693; cv=none; b=HgmfGbmkLtbXxA1YcFfiB7pZMUKqDfn2h40X6JzCoEw2w226csFsADQ3NPVy00XhnQFnTsLuy78cZuQifIKauGpN/ubl+CMiN7a/k3uTgoVsZlq/3gtFkORtAopodJkAVDsp3sB8IZJtGvbBEG3AngTArzVRcHQEo7FucAlziSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761838693; c=relaxed/simple;
	bh=mW+b0mZ0Xzoc1rgTkOGOcy4tpIVH1posyla2QdFqaqk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pUudS+XDfupwAxfyNmUJ8dAePF3Jg++lEI17beFog0/TxgNEOYF7YnYc9FZudrJPmJH5zLfmFvnH60OAQlm5/BFQOu4qjcrHPMrsjhJsrteIx8N49qzjULNz6aosq3dXPmfkQ4ASX3VBgTA9Vx9t3nGGWxyHfGUTmktjBKFPq6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eBWSXKRY; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-430ab5ee3afso11604155ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 08:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1761838690; x=1762443490; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M4rhNISJyn3MQmXHfnEF2nxTYwm6ZMRXlKsdLf5mgvM=;
        b=eBWSXKRYLbfiDbI/iSrUBks7XhTvWRU0I8tc/6Uvn1bL3EplmxWUSRny10p1oKdvhK
         RnYIrt2uSQggyF79y4ngYr55b523FFbGVlppHM5aMCCvE7YCYWkJRMMfVmvgZSdwLD3I
         gjZDnNNqSWnvGJheKiIABHATGTKskOFcY5MVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761838690; x=1762443490;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M4rhNISJyn3MQmXHfnEF2nxTYwm6ZMRXlKsdLf5mgvM=;
        b=Bme6KUVhhYiR9dz9qW6jOJg6rJlbYsKBWd+W8OQd7fUv/jSmWFHGpZDRBg9gLV563U
         nTbil8t2Q3hRTY3yZ2IaUme3lTo5kDDgu/p0RvmxBgI2x1jIhYJd4BzPG4N8JIeQ5alh
         TbV3Ewhmzlwi4cPbM7O0iOEGGk6AMR2OSN4DE3B0NxiPM6JvLGgY+oCQcVmmPHL4Puek
         dKyHkSXH1lMMuVWCsfj/fkJ72rhVBdp3EHdCrfOaBVQVhatfJ1laN9iOU9iTrvBiv2aa
         4FD66atRnzG+NtzdwhO0Py9PVg9DGWDAx7wQuH3cdzxTowZSrXn2cBdn9gWOXNroRJRh
         zMtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdyjCg3OMp/uEnJumc/rAfFPmnDzEXFklKsn1RxFD1Y812CUfKUvN/tHzmiW53L4BJiqPgwQlHNbtiuos=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/aWXy8M51yfvr4ipeMuQoxpzqPFlzjuR560QqukTjNhuLqXrL
	GLmTNiyJB325wJ1wHiwGqnyCLh45BigbWCDTylGkkPAeNzBDKiSX3GdD2/m0EZpVgJ6cdlXOlwU
	Ed2Zy
X-Gm-Gg: ASbGncvjWefCRhB2ie+PAYZ2CF+0+e+1slA9Y50HKLgx6diIZ/RlAF2r4Wgf/vxQD9H
	JPU/isomjFrRAtg3XLBHG3N2Bna85YobpGImOoPsgEkSkg+jYXs7RuLhywa8YkHPZ1YCNZqAIrQ
	lFOvVMYQuoBOxZALjw0zInx00SnmF276A44e42CQ1DoLg6aemH1+bDrUqu0GAKRZT5dyMbIgNj0
	w+YOzhvGBoUxG9aFjQfsglEEo4ibMs2xW2kRlJNvZM7fT73eR7IbLqkNsU7P4DcgjjrezkL4K3w
	RxK2dtL+Mdcq2/Ej2EMPhA26Vv06yoZwAsEYPl8/fVV35fN698jIy7yXHwJPcEGIlfuMIXwixJZ
	y5oDGFCSX1kDtVLwj8DIlOOh2LOpe6dH/ziKCEGiSuDVomcI9FmmGq+BDgieDoYOW0tmSoJQUao
	E2ywrPx9COuukTulgHEJ9h03s=
X-Google-Smtp-Source: AGHT+IEEQub5sLJ3aGuBouA92Z7nNZCPqtVdawvMALkZKTYfxOyi2b16vy5AGAgrD2+qrkL/YuY6LA==
X-Received: by 2002:a05:6e02:3b87:b0:430:a65c:a833 with SMTP id e9e14a558f8ab-4330d205bcemr2256365ab.31.1761838690330;
        Thu, 30 Oct 2025 08:38:10 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5aea995d179sm6740700173.47.2025.10.30.08.38.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 08:38:09 -0700 (PDT)
Message-ID: <67f93be1-b5f3-4945-8701-8e86d61bafca@linuxfoundation.org>
Date: Thu, 30 Oct 2025 09:38:07 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Add error handling to minix filesystem similar to ext4
To: Jori Koolstra <jkoolstra@xs4all.nl>, Jeff Layton <jlayton@kernel.org>,
 Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, Khalid Aziz <khalid@kernel.org>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Taotao Chen <chentaotao@didiglobal.com>, NeilBrown <neil@brown.name>,
 linux-kernel@vger.kernel.org,
 syzbot+4e49728ec1cbaf3b91d2@syzkaller.appspotmail.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20251028205857.386719-1-jkoolstra@xs4all.nl>
 <su4qka5wugz3asm3sakmptgeeogx6duj6kc7doom5r4fhdwdcv@ogp4lz5gxn7x>
 <792975039.3142581.1761826973320@kpc.webmail.kpnmail.nl>
 <1697efab0661c4c80831544f84c9e520f33962e7.camel@kernel.org>
 <1979215152.3123282.1761831106100@kpc.webmail.kpnmail.nl>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <1979215152.3123282.1761831106100@kpc.webmail.kpnmail.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/30/25 07:31, Jori Koolstra wrote:
>> Not necessarily.
>>
>> I'm not sure if your internship covers this, but you could start a
>> project to build a minixfs FUSE fs (if one doesn't already exist). If
>> you get it working and stable, you can then submit patches to deprecate
>> and remove it from the kernel.
> 
> 
> I would have to ask Shuah but am open to it. But a quick search turns up
> this: https://github.com/redcap97/fuse-mfs . I would have to see if it
> actually works and it does not seem to support v1, v2 of minix fs either.
> There might also be a licensing issue.

No objections from me. I was expecting we might end up here based on
initial reactions to syzbot fix. Since you are interested in fs, this
work you did for this patch is a good learning opportunity which will
stay with you.

thanks,
-- Shuah

