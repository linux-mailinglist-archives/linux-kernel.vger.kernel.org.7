Return-Path: <linux-kernel+bounces-793584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FE7B3D595
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 00:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4F6F174A41
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 22:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D1F24DCF7;
	Sun, 31 Aug 2025 22:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+AUpsrW"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1055B2253A1;
	Sun, 31 Aug 2025 22:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756679198; cv=none; b=dNUj3GrftfBRij7uHE0265mLA9ntIUB4tDRrw027bC6/AqXZknxcyKWhCE1J7PTCu0XKBm5dyJfi5NPifhfukytJ27d1ixb75a0C6I85GPbc3p9+b2yBmvfGOP5Ynq83CHJun+r4MDZfhgjcn2X05nKTKmgv0oQd7dA9vo5vIbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756679198; c=relaxed/simple;
	bh=jHJ87rT/K0fRtIQnkiu+1QCxD9q2bGvnKc9qDFuLV2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NCo2BTMxYGe4fb4/d7VoQGH0Y7yBWPJL/P5ppr97kKW9of9zZ3X+lzrsJS4iHQCOzn7Y1m1NH0X2YLtchJBcCSYqfXnNQG13ZzVjzrlg1W7UHEGmuj1V7iTv7UQI4jHSSe4Y52iciQmC1m8Zq2L2AaEsUob2jJV1w75d7PmhJpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q+AUpsrW; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-248ff4403b9so24815865ad.0;
        Sun, 31 Aug 2025 15:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756679196; x=1757283996; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GkOTG4s16xJPpIPPmhmVIyLPlxZ5TYnLEhb6pSlX98g=;
        b=Q+AUpsrWZDqIw3RFi5i8bYbdwH+I++QzSMTMOUFVNLrf6MQJrldD4O7ubaekFqE+6E
         KQvaOhiAMtKW7ek7yUxGzV7kRWqoaeoI6OmMqeMaAwDf4UnnyZpwEqyPRO/PdsP6EaGV
         zT3FklMDm/j8XKr3h03yMrSBS3BvxEVbmiWXigUybO29SMpwPJ1Md043DcRYYjkdoSUS
         BRl+gOtr1uMFHtovbBHBDEoaQyRNbYfMNWi697On8uz33PcqwMZ3CjjrRyO6nXDDpdMt
         J4Xts2djOyomiXXDgxYxhrSbV02s1pzGlgJboNM4C5A8swy9oaKtIK3iuAHI0OBv7Rg7
         ou2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756679196; x=1757283996;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GkOTG4s16xJPpIPPmhmVIyLPlxZ5TYnLEhb6pSlX98g=;
        b=BnHVtfJ8Zh10FIdy6GAOLozDOWUq3co9tLLViD2ISQeVCES4NX3Fr12aVtZo9N4nqc
         JHVjIpSEqurxYD4cEdQxT+PwNwhvUlDumMTzrUFZ2tjDWNvZ1qEvoNIZzTiThktIH7f2
         Ibe/v1I0OtBSvDs/JxPhEb0cY1/cn8y6OFPZ8lzHYkDNXQaA/BxM0gO7wsK2urp96vRn
         /3IC5VBbVhA5AhcSJTUlbU4fhmm5nS+cj2ukygGIP+c4J43zJbl6ZFAuErXvdPM90oZk
         KF/JLTWCYva3RmqOwRdLcE+9T8aaJq1jNNUZgmRa16l7oJZt4fhAMDhP9RpDGVwdvqSF
         BTbg==
X-Forwarded-Encrypted: i=1; AJvYcCVvMPrjhdJHaLurlj3NX/G3U0mMdf30uFr9VI8wBdc7++FR4hJfLi5za+xYw2bgPI7ShcYNaeAYEm8pzX+V@vger.kernel.org, AJvYcCWTVN26+7neiGaXUdRCf0zw8XDgbenVSpV8C8plKqtPRuv2FnW/014QevFudJV+mMikahhE96MCNgnZoBo=@vger.kernel.org, AJvYcCWk4IgcFlu0XHnjxTw34PygElD/1gQh0JXx1V7yZmNLpVwSWWg2YaFbx54JFFMUwqMA9SfnFG9syX4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx9DN+5AfRO8kNhWyCEG/DkfP1epI3/IimUxvhh/ABRS4Uh1+6
	ZSfhllqDAnOHEwibnqbURdsIm+zoJqPhtmwUsMAlHFFO8f9c8PE9oOPO7o6apg==
X-Gm-Gg: ASbGncuip3celYpa5bK4FcDumO2LDn6VAIRnSucFwXfrkls6jWGerVUHvuoAJ7G1yLU
	XF/QD0d3hxuOqMI5zJSvmav4A6oE+GtYNhbptmlFTMhxonjHJlf1kptHg6iS9Mykq7DopKiRmIQ
	banVR1k9mTPGXbo/7YO7mwN9DgTPj0jB9dnfYIjqERMk78nyQlCyWipBlfXIq1F5R1RH6RjtD1W
	7+1+l2SIf2b4+8pZV+lHeFbL/6YKT014Uc0yo7etf/0tXPvUZ/WvvF5z+8yDmmeaRFK5MoBmQmx
	mWkJQEMqFHltK5f/ah5FVhJLOVVhcPmshs3Pca7sTyRo1E4LXH34s6s2HO7HkS99W8GnAROwCMz
	/epfxBmbCgddy924IVEX0HNmVWBhj7z9pEDZJUCEJZNkC+g==
X-Google-Smtp-Source: AGHT+IFB20ujAd1iyUzwccwOu3+efPsEQtlvmofLVgAAn33qE6c5pHJ5x9OfqYjgPE8cvzKvXd4AVg==
X-Received: by 2002:a17:903:41c2:b0:248:84cd:49e5 with SMTP id d9443c01a7336-24944aa23ebmr90806475ad.31.1756679196310;
        Sun, 31 Aug 2025 15:26:36 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-249066dcb44sm83043845ad.138.2025.08.31.15.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 15:26:35 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 31 Aug 2025 15:26:35 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Debanil Chowdhury <kerneldev@debanilchowdhury.com>
Cc: ninad@linux.ibm.com, corbet@lwn.net, jdelvare@suse.com,
	linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v4] hwmon: crps: Fix typos in crps.rst documentation
Message-ID: <82a7d835-e90f-4bf5-9a97-42009b2da633@roeck-us.net>
References: <20250831045710.6009-1-kerneldev@debanilchowdhury.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250831045710.6009-1-kerneldev@debanilchowdhury.com>

On Sun, Aug 31, 2025 at 04:45:54AM +0000, Debanil Chowdhury wrote:
> Changed a misspelling in crps.rst documentation:
> "Critial" → "Critical".
> 
> Found using codespell tool.
> 
> Signed-off-by: Debanil Chowdhury <kerneldev@debanilchowdhury.com>

Applied.

Guenter

