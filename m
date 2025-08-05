Return-Path: <linux-kernel+bounces-756980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED80B1BBBD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 23:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99A7E1848B2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 21:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E689A248894;
	Tue,  5 Aug 2025 21:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="RkiHUbS/"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0DF205513
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 21:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754428942; cv=none; b=JSQzkFBSKU7xNFTLYXM/MLO9iJwTFzkTGfSXabR7khKMsK98dHcsqp17VQ4YYJzdVZwWyEH81EOvn2Wz0s4mAYKt/iib91v/HD65JJLKS7AOOf22tqmZ7vJt5kyxZULEPfRo6Q1uyXcRHU3YK+YKe5S48WKuVJLyW3SDGhGckok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754428942; c=relaxed/simple;
	bh=VEYrrDZbOZzcqselE3enFW/VmNg859MFte0n3Jvt1kU=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=RCqofbQPaoYAae/yvqbEFPhKPOAOy+ONkKuq0RBCQaAykMY2uozdaEkNfFD9qfnfYsMqQbuebdsQm9CQDCYOhocWdV4zGpX9n0Gq1jqdRdhuwg287U2wGk/VRfuvRSL54p6w+cyrAMLhF+BbA4vSn1ItfXuEDtz9VTvaOX8ZW6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=RkiHUbS/; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-70744318bb3so42539226d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 14:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1754428939; x=1755033739; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J/WIMAsJLS6lq3guoK7qgX5VwdaiZFYEEVoK/VK6IYA=;
        b=RkiHUbS/qLK8ilyZPQeocRrnAtYwXQL7FDU0drPkxxG7jc9+kvBlmSnwj4A65NS30T
         IbUyspMKxsMVebLqnHg6sKdmiYKCAfc3mv7hq5jw+DWxcnnlodGSjRzzxEsMBNj0kxb0
         GbEBinRgIoUSwld9pgEinFEVkX5Kwl36Iv/S9W4v8ieUIH1wFCjPkBnx8ZSwQ2JtFdn3
         UpaSU5RD1CUyTT0FNzz3Fum+p/Mup9YlJMfOmdLMRV7SfbEoT8yj/MdRcJidc+SlRltf
         fILeoQvl4x2rvavdgXuHA1E2zwMT6PET99yvBFB2ANXdeMW9O1Eg4jLltriNEymD2S29
         MsjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754428939; x=1755033739;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=J/WIMAsJLS6lq3guoK7qgX5VwdaiZFYEEVoK/VK6IYA=;
        b=LKqOK0xUCfYZZPdyeAD/2e7vLypdy/Qi/OesaZqem1sg+Eoh/sdk/1PTiY+FALmItZ
         xKv81tQQZPkUBXlMBwPvrlvxdQhaoEdAXQDGcKMB83CrkxNpHbdmvsLbxj/lIG58RXro
         UNDwuCf6uCipCAyeQRlCvgyetzI/Kysd9URo9uO9WWD/+JSegjadoBoqri8cHXyneEWR
         7L0eQb5gxBe/Id8GveS1Od1YjoLLOTLywnE/XE1Bs/8sorAmuY2spXYISAZbx9cb0IcG
         DUZJtPelwXwAEvISdOYTzxdEt4QdbYu+NsDbLh+JQcdrWL5JKr3aLTJlb9nVRCU9EhAC
         YCHw==
X-Forwarded-Encrypted: i=1; AJvYcCWfpgepq8IGvxAOO79sbRfjz/8lJbwkbqypquL3DVX8t1zIi3mqXvPBxH5RQf1YXEghyagOhebm0hXbBFc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzqdf1DU0IYbBjybN0I6SpY3w65gt0Sp9C45X01veRVeMho43p
	mcGfhJiDG7CBZ7oJjNH3kYhFjgWmOYNgwVvjRB410JelJysKEVjdFsdIppi2fw7GyA==
X-Gm-Gg: ASbGncsI73fXfVKIltngYWEI9W9Xl05B0D0aHG5RpEJ3IPo7TQIUgjc9XVanaQCnIQ9
	zeQ6xDdcsbx1bcq4XERBD8gvcCZlimbx69PZsXOdYXwv2xokL9snPB/l0d9PvcWqmBUBV6qHNVi
	q5SIL1Hti7nPE/rrD0bqt1hhZgLzTMp2qIvXiGvTL2qxB0jGPAaesZYu/u3yDheNfOWAHgama/Z
	puWXQSAW5VsKCZ8fPm9aHyci8X96xE6VYgpYsGQxkureYp4VGndLhMeX6sBtifOjuqsA4K7oQO+
	PbL2tWFsG9UBYaR70szFrILOtmqduqcipDLPbZAReTbgxK7E6PvjC9wy9AaM44WlkI7KM8IuOpx
	Nw6kGxK3DvZOjCL9gH/XpBdim5w4LUf5+4XtVjSvz+nc21p+WuMnIfyDP6MCBr3ELWVM=
X-Google-Smtp-Source: AGHT+IFMarL0V8vF5yt+ZnsWfT31K0Y4vayuTgbQn5WaROkr+RwRruDKhNk43lQFY3AMqk6bxFLR+A==
X-Received: by 2002:a05:6214:c2e:b0:707:621e:6876 with SMTP id 6a1803df08f44-7097af7c197mr2730686d6.50.1754428939371;
        Tue, 05 Aug 2025 14:22:19 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-7077c9d6d6csm76494806d6.4.2025.08.05.14.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 14:22:18 -0700 (PDT)
Date: Tue, 05 Aug 2025 17:22:17 -0400
Message-ID: <55eacb468bb0868fe2552944d46239b7@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250805_1541/pstg-lib:20250804_1752/pstg-pwork:20250805_1541
From: Paul Moore <paul@paul-moore.com>
To: Yue Haibing <yuehaibing@huawei.com>, <stephen.smalley.work@gmail.com>, <omosnace@redhat.com>
Cc: <selinux@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <yuehaibing@huawei.com>
Subject: Re: [PATCH] selinux: Remove unused function  selinux_policycap_netif_wildcard()
References: <20250723122304.911130-1-yuehaibing@huawei.com>
In-Reply-To: <20250723122304.911130-1-yuehaibing@huawei.com>

On Jul 23, 2025 Yue Haibing <yuehaibing@huawei.com> wrote:
> 
> This is unused since commit a3d3043ef24a ("selinux: get netif_wildcard
> policycap from policy instead of cache").
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  security/selinux/include/security.h | 6 ------
>  1 file changed, 6 deletions(-)

Merged into selinux/dev-staging with plans to move it to selinux/dev
once the merge window closes.

--
paul-moore.com

