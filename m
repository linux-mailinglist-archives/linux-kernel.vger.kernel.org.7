Return-Path: <linux-kernel+bounces-830540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9DDB99EFA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 14:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2C0D32791F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6412FD1D5;
	Wed, 24 Sep 2025 12:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ty8rWSqm"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165722DECD3
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 12:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758718498; cv=none; b=URBirJoq6uleQWtJ1YQdvCly83w3ycW4th7OgC2pGZVJq0knWiEGCpwHC/jrK/mPNAlXWQvoMDIzZF8fS+ODLFaSbdG9aFTmt76vtmvM2mICET6OHkaQo3xfkHBBjVhEhadoi1y841Jbb1lNcAyFI0AyCh6hsmUZ0wE2vwmXCxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758718498; c=relaxed/simple;
	bh=/h+BV5SZD7obtHJsFz12bUq2UapBcOsDzpiy6TIVFrE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WJ+m9r5eF6jwwAB2LzcRflEUO4pun0Dw0LYyaj7yJEAyCIPpP+6DMlpVznIyf+oasahBoGltsfaMvQHd/aHE69Xp0uVKFt+vUNkPbT6ZpTmErfNa/5VmTC9qqwZ/RGnFr0s0mxphGcYE1sMecnU87IlVfpd6dzI4aDqoQNFwGdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ty8rWSqm; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-77f22902b46so4318463b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 05:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758718496; x=1759323296; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xZjHL9JfxozniuHLv+c05c9n0ugGpAkyMCt7s6XaE3Y=;
        b=Ty8rWSqmdgH3p2FB09aux6lR/zhKkTDN0pfiMI0kcyDD3jDqQP/nUOQ4GxwXIVpiVY
         MjanAjFb/dZwXYlCpyTemxFIf2LWQ6SlfvGRb0f9eDlecEvmfiqnVP8t6ZsXWuR/dtli
         zZwGJpo3QYUNJ4iYPefwe8ryyV/5/5+hSCNj6bpqL4FOUDRGbvh04GG8Vr/SOkFAaFc5
         kZdpXWSYCFDOEdWpksWGssrJF17K0oi0B1V7y26O5roiAOEAS76iJwv0tgGaPr84uH7u
         SazWpeYQAT8XrggM2dgKQXDk3Ff1RkZIXWKvAvehtv+ukhhlN7N8jaY98/F4/T/Y7xDL
         vFWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758718496; x=1759323296;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xZjHL9JfxozniuHLv+c05c9n0ugGpAkyMCt7s6XaE3Y=;
        b=DKNl9cH7kqbbyY0DPosW6j9J1udMY2ZdiaF4ONgeuTsnZiip6ADTISaPfIKodUxEHf
         AOELNQ6LRJYhRqvEOk1+2IkQcMxHWtlLfMxskOv8m+WEcN6UxDvFoqBNLsOYr8W/FMl0
         xIO6NOve/st7q3gunCfBSWzh5lxEw6y84katgXcDpOEnYxEf9eJypLBvKf401aRUtJba
         pi9vr9hNX2wcHKV4a2nXOJ/HMTSw6ex2LcKLpKI/N2lBtz386utXmhHTz/BcJ8RBwaWt
         aZLQ6ln0DzL+2W3ZfHdAv6+jfkeL+XNVdKV8GDxwUboJL0YQLcbmdkTsTwMb7Un7Ckmz
         pLdw==
X-Gm-Message-State: AOJu0YzwWQjaV/Xb8tkG7pCduzijj4j1eFjR+r7OIEPh+ZekjpRGRFuo
	FW1kHFFkwCjWvZnxOE6yoSVkw/Emyq7/UA4BPRlrN3PKDd+76xfeCqAC
X-Gm-Gg: ASbGncu4ww9jk6PAY0f5QhBvs5K5b77VHDjCuyuvaaBH3NWSC03QabRYwKG0RWifJ2d
	qAyd6++Azvl6E0FPersjww7tQ7NUVdyU+xXTaIHMfcozj436fnuObakmjIC59DdOfEGOPsu7u88
	GvOn/4JXIi+L41/5OsbXJ5hhUN9Z+SmPj7yJ60yh9n04520zXUo0Zs7aq2ZGn3bu0TYpfwCVfko
	R67+c9iSuWgVj0G11P4nNL5RIzvmPpWTP8sXlNuSSNDR+qrsF12TpRSpVUxSbPX8X21yy0M9dB3
	dgsqJfjKhYgtY2VWjaTpH5KDwE/EWC9w+HKBHAcRYO/3rV1+SOzIx2DfTAS2+/qxoHjh2FB4unO
	qAtHAkegihfV/GIiuV/wqWQ2v0MsPVA==
X-Google-Smtp-Source: AGHT+IGyGR44p/+wkNNs71UbKfXtXoZY6CV/4Rk+INIgJ/j15iDcF/I+YEMWdZ3PmvfPa1HYYhTQ8A==
X-Received: by 2002:a05:6a00:998:b0:770:73ed:e6e8 with SMTP id d2e1a72fcca58-77f53a7a63emr7216256b3a.22.1758718496302;
        Wed, 24 Sep 2025 05:54:56 -0700 (PDT)
Received: from [192.168.0.150] ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-780fc88c823sm13374b3a.54.2025.09.24.05.54.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 05:54:55 -0700 (PDT)
Message-ID: <5cbca9f9-b8f5-467b-8602-3e0c927348ab@gmail.com>
Date: Wed, 24 Sep 2025 19:54:47 +0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] Documentation: gfs2: Consolidate GFS2 docs into its
 own subdirectory
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Documentation <linux-doc@vger.kernel.org>,
 Linux GFS2 <gfs2@lists.linux.dev>, Jonathan Corbet <corbet@lwn.net>,
 Randy Dunlap <rdunlap@infradead.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>,
 Miklos Szeredi <mszeredi@redhat.com>, Jeff Layton <jlayton@kernel.org>,
 "Darrick J. Wong" <djwong@kernel.org>, James Morse <james.morse@arm.com>,
 Bernd Schubert <bschubert@ddn.com>, Chen Linxuan
 <chenlinxuan@uniontech.com>, Matthew Wilcox <willy@infradead.org>
References: <20250911004416.8663-2-bagasdotme@gmail.com>
 <aNJ9yJ7XT4Pnsl9E@archie.me>
 <CAHc6FU7aGJZZzN8zhtnwDgXX9gVMh_fbi+sUpJ7tg1MWMa8XVA@mail.gmail.com>
 <aNMnSapfyfwga0Oz@archie.me>
 <CAHc6FU69a-R-u-Cr90aQMjb_75SChUa9BTSjL4AZKjuo_QVJQw@mail.gmail.com>
Content-Language: en-US
From: Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <CAHc6FU69a-R-u-Cr90aQMjb_75SChUa9BTSjL4AZKjuo_QVJQw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/24/25 19:17, Andreas Gruenbacher wrote:
> On Wed, Sep 24, 2025 at 1:03 AM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>> OK, I will resend after 6.18-rc1 is out.
> 
> I have added the patch to branch for-later. There is no need to resend.
> 

OK, thanks!

-- 
An old man doll... just what I always wanted! - Clara

