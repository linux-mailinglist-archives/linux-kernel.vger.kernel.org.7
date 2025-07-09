Return-Path: <linux-kernel+bounces-722713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39702AFDE15
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 05:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8748A567DE7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 03:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8181F1EDA2F;
	Wed,  9 Jul 2025 03:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="KXQxlaqY"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AAB1DC988
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 03:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752031626; cv=none; b=Xi3fsLOFkM3vsMXc//EHuAlLK+Yb1GYhCQnt44rz9p+eEKwAgiUhiMCe5TRbRJlcAKtZsMooLx92W/opSgNTphdJtKDaavrN5DFDCx6qHbuxRsjf+/dG0MGytFwPJ0eh9xttyOKu8fFDAkdKOYenmi4Wz9N0vPHSxCBcy+fvdC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752031626; c=relaxed/simple;
	bh=zw/fej0GkXW5A++Ge3FEYjbMmbv+hTBMbj5gw+U4//w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LP3gaKTmvYfdE/KqK+cVWJe3cJiq9xeeDO+/zybhAHfVdHsOGmQ6vJ8dbxoKoXuF291LRiTcbJyaQCcNNH8kiLUhg0yQFSKOEUD7rWDnETiTSACtXMeJVQ7Eunql+r0vz1ObavW1u+zV8GI9CxsyARrwqNUv8VeCd4PViGf9xxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=KXQxlaqY; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4a77ea7ed49so6837351cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 20:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1752031624; x=1752636424; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zw/fej0GkXW5A++Ge3FEYjbMmbv+hTBMbj5gw+U4//w=;
        b=KXQxlaqYQfw0jkMx0UszkFkz6yZAkJym2Y4XdWw6DJwfxo7h8FDx3GciGZ4GfjpWq7
         2by7ourxfJDrIk221f12+zzD98YK2TkxAwAEVam8W15bHr1Mj1EDYPPa85YXU51sAsSQ
         /b/56IISOz1C8GvDDn5t0r5YCFfLOOHuTQUNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752031624; x=1752636424;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zw/fej0GkXW5A++Ge3FEYjbMmbv+hTBMbj5gw+U4//w=;
        b=L2TjV0/C0z0A9sEjzQti598YfWAdPzSWyVhX+EKguc/ZJ1PUJxIkxcdp+hC77gu2fD
         kXQi063Xz1+WT/4tBy8z1r+MOTPGOQMUGMg+HQDRH3cB7VL5wVMrnkaeNiWBS5j0+4IR
         L046Q7Xiqr+Y4K6avVZuW3RjkEtgoDdJvy01+vAU30f8BVIXRGbUlZ559K4JiCi1/UsA
         Mlr0vNC4KiyzJkrdHP+hy7O67ay5pgydShzE39yGoGR5739Uzb064waES6MjJm/HwENA
         2//jIh8pyl5VpS48jWNLBtn10PVJPAnQxBYD/NNfhNCtV1aRgWzB/0gY8YydwrO3wmjB
         oDdw==
X-Forwarded-Encrypted: i=1; AJvYcCX1BJFb45fmNp+fwm4x4E7A1bcfvgKtWEm92O8+AstPvmFjdVeAaAh3RXC5qE60mKw7EyrXlqhUFe7TK2M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrCW596beIRoBQSIkjCnT7ouLOfiiPN3m0T8i18OS6oPERE23y
	p+aR9kuVwoDLxZ6X6VRkVMvwr2EgeBD12dcLgvGJbJPT/bgFPbdhpxv53D5UqjfCh0sPV93uNAp
	/YbR02DN4oUhLw9pbTA5INCcLIHzTaooAWZkxjw6/Tg==
X-Gm-Gg: ASbGnct/mO+9YXCDcGNCWWmhx2fvvAMqjln5coe22llDbpPCw3rNeH33G6Rugn7h0g+
	jkfOFLGO7CtTifRXr9J2bUeJ1AmyODfyoc9De+a6w4YEQYor2yoB0fDcIEyb963q2S6VXoZ435i
	IZyRsypJBLQ6jHlYKrY9GueWr04fmPKpDBAqStdBODooXK
X-Google-Smtp-Source: AGHT+IEbfuPtiB8SJ8mM3IIy/0e+1oWhx4UxNRjIANMV3UTN0UVNRrT4FqNMCrH6Q0szGd55OwaVpm23wRX15i4H4tQ=
X-Received: by 2002:ac8:6f19:0:b0:4a9:8b58:6300 with SMTP id
 d75a77b69052e-4a9ce5bbb43mr86267521cf.16.1752031623903; Tue, 08 Jul 2025
 20:27:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703185032.46568-1-john@groves.net> <os4kk3dq6pyntqgcm4kmzb2tvzpywooim2qi5esvsyvn5mjkmt@zpzxxbzuw3lq>
In-Reply-To: <os4kk3dq6pyntqgcm4kmzb2tvzpywooim2qi5esvsyvn5mjkmt@zpzxxbzuw3lq>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 9 Jul 2025 05:26:53 +0200
X-Gm-Features: Ac12FXw6hgYHynMi-MN39oWlDifPLmPqesU1MFQWRlURFDaTLnL4XYV-SQPgaEw
Message-ID: <CAJfpeguOAZ0np25+pv2P-AHPOepMn+ycQeMwiqnPs4e0kmWwuQ@mail.gmail.com>
Subject: Re: [RFC V2 00/18] famfs: port into fuse
To: John Groves <John@groves.net>
Cc: Dan Williams <dan.j.williams@intel.com>, Bernd Schubert <bschubert@ddn.com>, 
	John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	"Darrick J . Wong" <djwong@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Jeff Layton <jlayton@kernel.org>, Kent Overstreet <kent.overstreet@linux.dev>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Stefan Hajnoczi <shajnocz@redhat.com>, 
	Joanne Koong <joannelkoong@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
	Aravind Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 3 Jul 2025 at 20:56, John Groves <John@groves.net> wrote:
>
> DERP: I did it again; Miklos' email is wrong in this series.

linux-fsdevel also lands in my inbox, so I don't even notice.

I won't get to review this until August, sorry about that.

Thanks,
Miklos

