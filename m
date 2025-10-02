Return-Path: <linux-kernel+bounces-840475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A18BB4826
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 18:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D43D42455E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 16:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E18257AC2;
	Thu,  2 Oct 2025 16:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="g3geQkDK"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD4F24A06D
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 16:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759422010; cv=none; b=CGO1TW/Vjg5MGzfkJR57Koe5AiApA9qI5l3i+5zqCGbLZLtYblNDxtynXlCLgWy0dSAqlBc6k3BTrydOcEQebQZ0bVv3dfFodrmwUugPEBVxRDOEIchY9/VLK5K+W+lmAEAyKK0ZD0ywshzabIIZ1b5w66+gkJFK9uwoXn9mCeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759422010; c=relaxed/simple;
	bh=YtoztTZpT493VJvYTsBfHF9fGrezdnnI53lqfPOVe3E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BU2kwamKQ/f35q61WmLaXboLg+zIQBs4o2j0P1KLcZanR3gDcfxGg4JMQ5lkG7D2Q7DOA04Keh5GDH837s5xpqm2e43aAg4q0vVjxg+IW14MVu5uMfVRG+uaNYWQ6kJfgEwmkHLdjY+2dB2rP9Mc8DL7NBdXP4AfR8n0A/ichks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=g3geQkDK; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42557c5cedcso728466f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 09:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759422006; x=1760026806; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YtoztTZpT493VJvYTsBfHF9fGrezdnnI53lqfPOVe3E=;
        b=g3geQkDKf4/4TkHGcXPSEnrc7fNCGJ9z+/yGoGNw01iHs2K2C0MWfbGJvZhYp9p2X1
         1lIjegCsVZGRgVUMGtvH1lKDMUA57j73BMqLeFDAl+1SSTZjq3J/JogwSKrtF+DFvcE1
         gNloWvlrj0TvZcsSu9Q6D2P3OS+/LLoo10TXqpQtPBJxN2n2Yt40cA6LBS3t2CFbMCZr
         fZIRsOa9Iiav7OLXdEWZqD4vN/6BRuZUj9xJVjnmxcsNL95AKeBzmyqr7v8CtTtoS+/k
         8B/Im6NhhU6Pqjo2lKtx7V8dBREte90K8cNGYHlar0LhzffSGJo5VcAeH2CBSmlE5KLD
         8Qqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759422006; x=1760026806;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YtoztTZpT493VJvYTsBfHF9fGrezdnnI53lqfPOVe3E=;
        b=kRVv9jILGlyI0ZI7OMClDDUyn+zgXpJdHBGyVotZmbwMw20dlrpVHV6wPoTJemHkHL
         v3LXBJUQ5I7HW55a4ga5Q/IXuCmi4uOj/S9rojY4hyd7mCpqUc2ayOzRpIWnMdXYRERg
         bWKxUGly4SZLkj19g+zTuXAW2+dZjOBD3S9LGPnivtNwQNNLWXnQX5jispRa9Irr6ZQE
         8HkClc+t54iY6yH/Y80hdfxmSdN8rJpgps68UhMYanqZ70+Wc1Oep2lCZuENeJKWu/6x
         cEKoaQz8KXGVytm9x6G+NEbUNejl4XStB+cwjWFJlb0cNlBaN/Ue9lSfJbA2DFllxHff
         ItQw==
X-Forwarded-Encrypted: i=1; AJvYcCVOWbcW13tkazZ2IUeDa2oi7/EK1eQJjTbhLcOLIfaC3IKI2kPMyB43YLkBQsMKxCZ7Wq8nTqSDXrIvwgc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ9ZfRMPTUFH6uTje/bMOpNzxqm9KjoZvE9/vhklJcnZ0gmk61
	zJYjgrj8l5ZEpI+FcZKoOKgsuMZYsFNU6v5zGsTrd+2py6nwFPDKR6DIU59b2nAqLIY=
X-Gm-Gg: ASbGncvlKh4sFSfmkMKNRRS8wS77q38EmVrVLw8rkrhYluFtlhK39ZnLKANqUZ8Sg5i
	cHv3IUvXGnrbSgR0d0VNQi/Zn5+WgT3Zc0BmtRgKSN7eJwaH2+yFPh8C5h+Rbg9+OscSVeFFs3+
	gcA8k2c2Ju6BRKzLQAy3B3W711UBzS3S8RBkn28apebQobC7KbgyZXf9y+zF3k1FgdIvnUN7bi4
	sOLMem6tF2SKCaurN1aeGW2wKPVU8IrDNQrlo/JzYh2rBlle/vUZCljQ6vUXf3lGo+batpm9mHc
	NK/3kl2A0PAyl23CNGDcbQprI0g4iCWvGl1Q2MMteshzPw2hYnJbHgwjMfgWcMz3yvVW1hxbueO
	tt+7fm7ZNBsNTU1wWJlvID8I7bKGjYkKc39TrdWqiZpv7FOw0m3EccJY1zYyOuXh6Hh5D1NpmOT
	alxtbaeb6g+T8=
X-Google-Smtp-Source: AGHT+IG/8V3uS0ueReEH3p+UtImtOhcwzPx59UfdYShjuz0ncxYW8UPmgBPsCDoK0iwlEoHgFVf89w==
X-Received: by 2002:a05:6000:220c:b0:3f1:ee44:8bf6 with SMTP id ffacd0b85a97d-4255781c242mr6304140f8f.51.1759422006324;
        Thu, 02 Oct 2025 09:20:06 -0700 (PDT)
Received: from [192.168.3.33] (120.39.160.45.gramnet.com.br. [45.160.39.120])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8abf38sm4167330f8f.20.2025.10.02.09.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 09:20:05 -0700 (PDT)
Message-ID: <4b1eb94db3c0e43f935930fccae5726dc381ff9e.camel@suse.com>
Subject: Re: [PATCH v5 0/5] Handle NBCON consoles on KDB
From: Marcos Paulo de Souza <mpdesouza@suse.com>
To: Daniel Thompson <daniel@riscstar.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Petr Mladek	
 <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, John Ogness	
 <john.ogness@linutronix.de>, Sergey Senozhatsky <senozhatsky@chromium.org>,
  Jason Wessel <jason.wessel@windriver.com>, Daniel Thompson
 <danielt@kernel.org>, Douglas Anderson	 <dianders@chromium.org>,
 linux-kernel@vger.kernel.org, 	kgdb-bugreport@lists.sourceforge.net
Date: Thu, 02 Oct 2025 13:20:00 -0300
In-Reply-To: <aN6FvQGj2w70Ejrz@aspen.lan>
References: <20250930-nbcon-kgdboc-v5-0-8125893cfb4f@suse.com>
	 <aN6FvQGj2w70Ejrz@aspen.lan>
Autocrypt: addr=mpdesouza@suse.com; prefer-encrypt=mutual;
 keydata=mDMEZ/0YqhYJKwYBBAHaRw8BAQdA4JZz0FED+JD5eKlhkNyjDrp6lAGmgR3LPTduPYGPT
 Km0Kk1hcmNvcyBQYXVsbyBkZSBTb3V6YSA8bXBkZXNvdXphQHN1c2UuY29tPoiTBBMWCgA7FiEE2g
 gC66iLbhUsCBoBemssEuRpLLUFAmf9GKoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 QemssEuRpLLWGxwD/S1I0bjp462FlKb81DikrOfWbeJ0FOJP44eRzmn20HmEBALBZIMrfIH2dJ5eM
 GO8seNG8sYiP6JfRjl7Hyqca6YsE
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.0 (flatpak git) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

githubOn Thu, 2025-10-02 at 15:01 +0100, Daniel Thompson wrote:
> On Tue, Sep 30, 2025 at 02:21:06PM -0300, Marcos Paulo de Souza
> wrote:
> > In v5 only patch three was changed, changing the check for KDB CPU,
> > as suggested
> > by Petr Mladek. Also, it was based on the recent panic API [2],
> > which now sits on
> > -mm tree.
>=20
> Do you keep this work in a git tree anywhere? I wanted to point the
> kgdb
> test suite at it but the patches don't apply cleanly (even after I
> grabbed the patches mentioned in [2].

Yep... my mistake! I had rebased my patches on top on -mm tree just top
get those patches that I mentioned in [2], but then I rebased back to
master, which had some conflicts...

So, now I just pushed my changes on top on [2], which you can access
here[3]. I also included the revert of the code that converted 8250 to
NBCON, which is easier to test it using qemu, as I presented on the
cover-leter.

Thanks a lot for reviewing and testing the patchset!


[3]: https://github.com/marcosps/linux/tree/nbcon-kgdboc-v5

>=20
>=20
> Daniel.

