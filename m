Return-Path: <linux-kernel+bounces-892025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2789C441EF
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 17:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60BFA3AB450
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 16:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0983009D8;
	Sun,  9 Nov 2025 16:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OubG2IeQ"
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1D02FFFBF
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 16:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762704438; cv=none; b=LLqhFFDBeXREkCHBOmNNY3HICTGLIvW6PeyUUGBpHyeOjCjoedr4YLlbrUkT1B4IrhDBNMMtvJtETIo9+ZYTtbndYPMvo03n89V7u5cpPC/x68sF7S8Ee0FnFGi8qKGjUiBWCoZlgAi7d6yupBCd1niICgiB7TZcu7tw2Lpd/wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762704438; c=relaxed/simple;
	bh=S9fgHs7LNXxCjvnR8z+jGu2x4XIB8BbhT/m8R+mBEHI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f+8wzHiwZukXpLRlDp9adeazzLaC6RIj0uexgst4SK/IduFuI/Vht+U/4Xb3x/bnhipENGIQAqWjLKx/2YhkZ7LlvA3JYEaMdF3wyuYaUMIjoAEAEoQzgDJg6Z/3rs6q1lsbnBGd85PztH6AXU7OL7an8fXqw6MIuCNDc99+UAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OubG2IeQ; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-4500a6fb71aso860474b6e.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 08:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762704435; x=1763309235; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=S9fgHs7LNXxCjvnR8z+jGu2x4XIB8BbhT/m8R+mBEHI=;
        b=OubG2IeQ9apOtG1a8WekuXVvEf7ERNl3jeXicoBTIntCu7pBJ0MLvT5+CJcod26LVo
         TIdWeKN5MNnnDsZrT5eIDzzrwW/r0YIDeGEI84nceCbus9GuTHRYNuWnp9K4b9DVyxkg
         v7EU46q4Y5o6sTR4zZ7bJagrFyM/wWZTyLfHK89HGSRMdfyNS+iVLDTWwFT3iSN4mEAb
         6x+EBCPa6lXmn1IW+dDWtUe1hE3Zc7YbMH+4FgxRiv8i6InVsObOK+MEzVopZRPAUxJV
         /i2h035NVAoFZXXPkcH2cL3vKZq0Mxu2Xq0+UzQJmW5cBJnipewoR9pc/bNYDQywPSpJ
         rT8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762704435; x=1763309235;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S9fgHs7LNXxCjvnR8z+jGu2x4XIB8BbhT/m8R+mBEHI=;
        b=na9z/M7BW1v+vUzr7JU1UW32ha+k8BU/+9YASWbQtHagteCHj357ENP5ofxXN8ZiDA
         KQVDGqYZqWuvYygpWSThkBRSVqD8skmm/q4JOchYERruZiMjSk6Ha2ivlTAnkM6n9LhY
         /n8McU+aqfCIccya7hz9xE7jwHAmdyTY5wmfWML/Vf2ivlHQM8tUKDlWTmxtSmwjOc24
         eiZCPpUiyb8YDvZLkXq5GK8w+vi6dwPfRFfCROLrhF611b2BzP2LWQCKO7Ld41oUvQ+A
         ARZhu35CzsnA0VtKV8QV0VLsqEp5CExw+G5FaMA27hJ4XycyzxDeZYNQqP42qOVYbZkM
         FPmA==
X-Forwarded-Encrypted: i=1; AJvYcCXSb2la4riCECPAillRtkShJkX9AQhJaLCE5S+1bCwaX1F6HGdnEexCcLAKlfzoaFQW7KrThWgB/pCjwHE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM17oCLOaq4ThpZMUAXCe1tmgLigA3RkTbVHwhDbRSVyjYJeHK
	PDfGkMDWcA+QC/MgmEwm40K6G40wpA17w/7TGMPL4B1LuuPNIWwl2PU6
X-Gm-Gg: ASbGnct03WmhSxdWre7ZY9WVqfzEDyP1qHPJiHglMcHU8AF0j/4arEKN1xGXUEfrmTZ
	2h6K9u5sRqZn8XIPG+4tZIYQRMoD04kHtBgCNTixSEhCZkggLegB7NVOo7dT4Z0THw02YO+M9WB
	kMB4N6gvo1uwG5TzCrgkJVLnxAs86GzRQ6hUGLMTeaNaNKvK2oiGDK5bgwOud1W/zmtOxQdqOTj
	+kY7peh+lxtK3A79fuqvQmQFYBLXJ1bpV8smiy4nfcCpdxCF2WNG1/VzsZ+rkMQMiAeYUyqUxuD
	KTSalRmCNpxysiHU7w1RlOgH2eDrjU04Y3IeBMQgxpjcYt5/UTmQDbN4ctBl5TPQCDILaNwCdLU
	3j73YJ8CraqcXyH5eCGyS1CqwVnPWhNz62hUVKBcybrvonIuz27s3k446cJt9EU4tMdNQdPQd1v
	sM8wxwzw0VIlV4YRWqKj6T6EMo8li1CGB4Cz0QrsH5ax7YDmI7r8ch/Sfi
X-Google-Smtp-Source: AGHT+IED6bY5qY6cxFJr2d2ngprwv19bCwEkOcXrTloMgrXhgTLDjUOuHRGjxqnxhNBX+x9pqayApg==
X-Received: by 2002:a05:6808:f8a:b0:44d:baae:fb0a with SMTP id 5614622812f47-4502a280b80mr3116020b6e.5.1762704435376;
        Sun, 09 Nov 2025 08:07:15 -0800 (PST)
Received: from [10.0.10.56] (57-132-132-155.dyn.grandenetworks.net. [57.132.132.155])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45002798bdasm4627637b6e.17.2025.11.09.08.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 08:07:15 -0800 (PST)
Message-ID: <0947877aeb6ff8c09bdd3bfcd8a9d2602bc54851.camel@gmail.com>
Subject: Re: [REGRESSION] af_unix: Introduce SO_PASSRIGHTS - break OpenGL
From: brian.scott.sampson@gmail.com
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: christian@heusel.eu, davem@davemloft.net, difrost.kernel@gmail.com, 
	dnaim@cachyos.org, edumazet@google.com, horms@kernel.org, kuba@kernel.org, 
	kuni1840@gmail.com, linux-kernel@vger.kernel.org,
 mario.limonciello@amd.com, 	netdev@vger.kernel.org, pabeni@redhat.com,
 regressions@lists.linux.dev
Date: Sun, 09 Nov 2025 10:07:12 -0600
In-Reply-To: <6980dba4ac0be1d6bbed8cb595d38114d89a14f5.camel@gmail.com>
References: <caa08e5b15bc35b9f3c24f679c62ded1e8e58925.camel@gmail.com>
			 <20250920035146.2149127-1-kuniyu@google.com>
	 <6980dba4ac0be1d6bbed8cb595d38114d89a14f5.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

> No worries! I just applied this patch as well(on top of the other two
> in the order you originally provided), and still seeing the black
> screen upon resume. I am seeing a stack trace now when I check
> systemd's journal, which wasn't there before(not sure if its
> related).
> I do have the System.map as well for this build, but not sure why
> everything seemed to end up so cryptic. I'll paste it below as well
> as
> my desktop:=C2=A0
>=20
> Desktop Environment:=C2=A0Gnome 48.5=C2=A0
> Window Manager: Mutter (Wayland)=C2=A0
> Distribution: CachyOS

Just wanted to report that this is no longer an issue now. I had
avoided suspending my computer for the last few weeks but closing the
laptop lid this morning on accident, and it resumed normally! I also
tested going to the power options and clicking suspend there as well,
and it seems to be waking up normally again. Not sure if anything
changed, but wanted to let you know and thank you for helping!

Current Kernel Version: Linux 6.17.7-3-cachyos
Vanilla Kernel: Didn't test since its working downstream now in Cachyos

