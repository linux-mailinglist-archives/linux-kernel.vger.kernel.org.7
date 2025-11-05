Return-Path: <linux-kernel+bounces-885815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80641C33F82
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 06:09:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1146A189F5BE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 05:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67EEA2264B1;
	Wed,  5 Nov 2025 05:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zh97NCMp"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629952253FF
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 05:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762319354; cv=none; b=GBP7UW7E0HepJh4P7QuYzbNXrjLc6+CU0M2hzXMniurih9fDGOsgMSrRZggbGUcGAmEAzSJocM3isjGtEnTcMBmMuOyBY0omTVpj+o884JSLEI4KyZa0MTMHLX49alaJdswXWf+ez6Oj9tD1q6XXdhxHmikkc0b35iDW6WjX8EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762319354; c=relaxed/simple;
	bh=ybZ89ka7wGDINL+cQOZrFSb4b+fijqyUProWsGPBleQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zozv07LKKDX0mdKusfOjAeqA0MOQv8qn94InUh7wfNwfRrALfIpgzZXbG0iieytepxvxjuZAesyH9YBUIgtJYj808kjoRxeiL1RCm9Is1Mati24KMZnfQQkZxKaKxtsTQzjcqDDrwsgOpAd045nsF8Wmj01cwgx1qolHCwMDmnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zh97NCMp; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-ba599137cf8so252175a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 21:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762319353; x=1762924153; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N4jMs5y2tALWypfJmfBRbWA98qIJqfeZbOrWjS2kNYg=;
        b=Zh97NCMpsXcF82FLlFBC+RV/2yzgdrQBS5+t66RJ4W+uUt3GEidnLL3fkbHzYFXiLK
         OF5FLIqLA9ZGqsk6tam+Ui8F6crhCw2TnlTmuPO5lUBVQhbVlP4me5/3G5jTZ1njrhCF
         AHms37BJ/Za+fUT0cg6I/J+R2VuP/+WflbGPF/LmPGurXYnNmXiJlqftkbZUD0tE+9o6
         qzhsyf8OQEXI48WjXM4bpplcT6ge1hO6PJZAK5ArKK5AGWhyYfYWnuw3YkFgjc57+xeV
         X/+EkZV9aHcXEhFpG34/lO0AXE0pX+k2MWpFZ+hsSXVeRypmw0rFGV8TSSx87yvZ5tc2
         xcEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762319353; x=1762924153;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N4jMs5y2tALWypfJmfBRbWA98qIJqfeZbOrWjS2kNYg=;
        b=rkEGvKZQH5iCpY1cbEQNkYBwOfwEvrBlpK7MxM2S2niUqlz2Fyd9XHCvDu/Akszi1x
         oEsuCb2ABy7A08ZOBz5hzdy8jk4DV41f5ihU8b2PcK/hdE+DavJGlrQ0oQNiL80/0Q8X
         ESxuI/NRiAuZcBjtpUZAQorjHiGSLGq6qNJ8Hp8gFnD/BF6b26OdHwaSYguHYxA+uua9
         Xils431Iigk17/lOoyBxIC8s6hGQxS+DCPiAZ5p8PeFmf0tw01aoijHdZTweDb84lzTM
         Yv3Ruf7xm2LxFPYHdDEGafpgEBAMYt7ngPj2dOQ/spdK8LQMMJih+0I5ZYsA/WR1LJVM
         S0XQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTbQXdGKCgwCvjkusp3OtHgGh48xlpPQAcJjojwhe+MO9ZTLxZOJAByVwJMEPKGZVmGnuRmFAw/baoMbA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvalx6oDE8/MZ6LlxkP+6O0XWlS7DojwTfPOQjrcvX9S8YykuL
	mG4v78pqb3RLYyoZZDezTp/7AtEpYVudKwY8vOEPIUVIqE3++UDtahvhPMzqIA==
X-Gm-Gg: ASbGncvkDmzD/DXzKQsZLzHb6HLYychZT8CT6yZ6CmUylmBDdGUUIdyALIf9Y/huSFQ
	ciAVr5Y1zYQyeQyiVrEOldFB03AumXoHbj3D5bIdOt8MEY/v6lD1FS7ZU/4wdBg1VKsuQxMJwsR
	+d79ebY1qt19SoHRu6q5OKlmU6L3v46mruu4HKSz1a3ZV2agO0E51//6dtUkRhMLYY7/hsdupsk
	+fURv94/Zj8mWtGkUHnfsn14M2CAqLWWFIUvnKlGXCl10iFQl+G/w7gY6LFSY4UE+tgAgXFO5WZ
	IM0LiccOlX4HHVMuTKmxljy5zA+tSr1dHwYm7z0UOHbOA4YK5xEOdxnCwv6kJBZ9ueIo24AcPjN
	842CP6wOaH11NZ6r9cccoaNDzQxrHKqMgpswkb5W1PI8qMcA3xuUfRSih9SE81g8vwzGs9RHuL+
	FMy2ApKhbAk/PHHwKJypnQc4TXh5Z1txkhbS/jDyJvzw==
X-Google-Smtp-Source: AGHT+IEr5MKnCuWVOr8OEra4PZxiRaRvqfcFqibr+fC/r+4cxI7Bcc7xaonLIv80+FULlN3GIHRogw==
X-Received: by 2002:a05:6a20:734b:b0:342:1d16:80e with SMTP id adf61e73a8af0-34f6f7d100cmr2761252637.4.1762319352618;
        Tue, 04 Nov 2025 21:09:12 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:86b3:15ed:c006:18d3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7acd5d57827sm4777076b3a.51.2025.11.04.21.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 21:09:12 -0800 (PST)
Date: Tue, 4 Nov 2025 21:09:09 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: Jonathan Denose <jdenose@google.com>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, Angela Czubak <aczubak@google.com>, 
	Sean O'Brien <seobrien@google.com>, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2] Documentation: input: expand
 INPUT_PROP_HAPTIC_TOUCHPAD to all pressure pads
Message-ID: <ueksimssfw7eqxa5mfmxruj2ghtuncznhbgdxvoorjf6jhjfhk@hsuapbn3kie3>
References: <20251030011735.GA969565@quokka>
 <20251031041245.GA1316325@quokka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031041245.GA1316325@quokka>

Hi Peter,

On Fri, Oct 31, 2025 at 02:12:45PM +1000, Peter Hutterer wrote:
> Definition: "pressure pad" used here as all touchpads that use physical
> pressure to convert to click without physical hinges. Also called haptic
> touchpads in general parlance, Synaptics calls them ForcePads.
> 
> Most (all?) pressure pads are currently advertised as
> INPUT_PROP_BUTTONPAD. The suggestion to identify them as pressure pads
> by defining the resolution on ABS_MT_PRESSURE has been in the docs since
> commit 20ccc8dd38a3 ("Documentation: input: define
> ABS_PRESSURE/ABS_MT_PRESSURE resolution as grams") but few devices
> provide this information.
> 
> In userspace it's thus impossible to determine whether a device is a
> true pressure pad (pressure equals pressure) or a normal clickpad with
> (pressure equals finger size).
> 
> Commit 7075ae4ac9db ("Input: add INPUT_PROP_HAPTIC_TOUCHPAD") introduces
> INPUT_PROP_HAPTIC_TOUCHPAD but restricted it to those touchpads that
> have support for userspace-controlled effects. Let's expand that
> definition to include all haptic touchpads (pressure pads) since those
> that do support FF effects can be identified by the presence of the
> FF_HAPTIC bit.
> 
> This means:
> - clickpad: INPUT_PROP_BUTTONPAD
> - pressurepad: INPUT_PROP_BUTTONPAD + INPUT_PROP_HAPTIC_TOUCHPAD
> - pressurepad with haptics:
>   INPUT_PROP_BUTTONPAD + INPUT_PROP_HAPTIC_TOUCHPAD + FF_HAPTIC

Should we maybe rename it to INPUT_PROP_PRESSURE_TOUCHPAD? We are within
a release of introducing it, so we should be able to rename it without
much fallout.

Thanks.

-- 
Dmitry

