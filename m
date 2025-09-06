Return-Path: <linux-kernel+bounces-803999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B42AB4688F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 05:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A9BE1BC23AF
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 03:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13AFDF9D6;
	Sat,  6 Sep 2025 03:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MQlVNbzK"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E10B15E97
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 03:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757128524; cv=none; b=bcd8UxximwfcS7MES+j6XbgDb1HJaT+BF/JGc1gjwk9vg7sLZfU2adH9pnrcYnyYd1QFS56CYitk5S6a0IXjV+QS6Dl701wwhU7Yq0BXtZw+fFfEFAMrGyWEBLy+YmoLvIoqF6KwRm5ievQ3eY6CTZU/WzSn6vWdqGwOVUt/DXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757128524; c=relaxed/simple;
	bh=AvlMdw25eCgMu0dHMlriCCLoeoNd2IN9QRBLOBFWx7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OtDHui6XD1oGduvI6qqDlruvL4WWGrnUc1pobzOXTPMC5FP2TzXzb1UyNhZiSUxQpp3H9sd+FH0tzBCR+gLEyxGBKgpT4VDL4XUF57u5nRpn7FzwA9M24+o0usiUfnuKxxFCknSzvrl0HVy6Nv8nga+QLH9pEaioxviaWvCDq/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MQlVNbzK; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-88762f20125so190316339f.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 20:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757128522; x=1757733322; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g44f+BPw5Hi5G4yK4fXujHmXwUWXbVPu3RwfoHic3HA=;
        b=MQlVNbzK2Bw7FkR9TCxyaX09JnoIb3E+dRTTiprwhrB9FF964ngajLGdYZI8FT+UQ/
         PwmDs3HId3pZ/gBzpMRrGE2rjY+dKaajO+cmJm2v7PxbP3vu8GFwtAm+bQD1kPXyQSD/
         q4nYPz5OHLT06osuiR75mfsW601HjFfcCTkJbwJIAKYF9/OF6kzDDUN2R6BKT3LBCQS4
         b98sTR7VUyFNGA0yws5PR0yIfPmsSNoq4Sh7mbE+OSqITpW8UiYbSot2fuflTfzYYo9W
         cxQ8ZhZvvsMnSM/Z3YuLknkWL+ZrpByX2eX++sM4eEndOpDJIiobEEZR9xUeJ2+E1CtL
         W64Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757128522; x=1757733322;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g44f+BPw5Hi5G4yK4fXujHmXwUWXbVPu3RwfoHic3HA=;
        b=Bmij2M+eugt+CCYlXIRNwaL+GsB8roasVZGRBh0BA0eYmLxHYX5uJCdzPp4f+NARfu
         p+KiKYJMUYTTO5yg/g0zbN/1AJAe78nP+45eRJREnfkT/FSLFkO4SGPs550ArH4rAoNg
         5oTcyPutVe778qJRHXQh6sFkPHx+7iZlY4GpJh+jRcEYwjI2IUccaN9KnCNJr0fkb2Jx
         jryIm/PMH3hSuNU5CP5XjCYBTjHj4kiJOEQr+0Rh1KpNZS/dys78597f7W1wcoEyxXLs
         Oy9yZrSbgL9CBJjOXiuR+XFmI5aWpfN0NQilUuvzabn+qR7Rr7kkiwxxsJbyX+jr0ep3
         VKZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCM6CtA8+i6m9wGgLhRbgyD/1oHNNy75k1Bz0o+RJP20HFBRbo6a85vxdQau+HsXs9AYeCDluzIPhE4zM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9XdmIW+LQCtXSbGrM94tu7+pqDccaDPkuEi1pd1KBlWafh30N
	tlEzeR3ds9aLrpFqHsJy0spRXvzWsPTC5xCOwDR2Ux6kgupSDQ7WfzJt1uDF2tiJ0A==
X-Gm-Gg: ASbGncssu2u7qJUwPn+ns8ZPOMtvthuPF30AFWAY3hX/Mr4ChcqAmTu4HbFTnak6NZM
	3VZXp6iVcDnipFA71zgY0NizlSWjMZXpIX3cZwt3RPF9FRh0yWJAoFxnesHTszNivgOR1XVLR8V
	ux0EnEFoUdlV0p40dLAJxQg/bsDbxNzvBLHveHz0AbAqRJ0NEAkZeojk8jFUuvxBJhfRWcJFq5V
	FMbhg8XYOWsc3/23rek5BGvr/C8iQxKHrt8+qo1WPzTAMEssSKCqenOYhGxZ5kGtKqoB89jDfwA
	Ni1D1JrLSWJ0PmSh7WWSPz3N3NpJVxwjX1R4K1gePrXO6jXBD9UvaIdhQ/vVFAAJHO1h4mt2Jck
	3i5PALf0BUY/LMTzXbpv7xyxEQOv9MDQk1OlfXfDbRkniQEM2noSUZ3pgd15voLiNYnvFog==
X-Google-Smtp-Source: AGHT+IGLw2fIxxDwuYWLRzhDla8WwJDRsF96LtIboEPn6HhOZqGVG9ZppVZ6OQM5ivQzCu68n0DXrQ==
X-Received: by 2002:a05:6e02:214d:b0:3f6:63c5:74e3 with SMTP id e9e14a558f8ab-3fd94a140camr15675845ab.16.1757128521855;
        Fri, 05 Sep 2025 20:15:21 -0700 (PDT)
Received: from google.com (189.227.72.34.bc.googleusercontent.com. [34.72.227.189])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3f3de24e723sm81698055ab.7.2025.09.05.20.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 20:15:21 -0700 (PDT)
Date: Sat, 6 Sep 2025 03:15:19 +0000
From: Neill Kapron <nkapron@google.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>, kernel-team@android.com,
	selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selinux: fix logic issue with per-file labeling for
 functionfs
Message-ID: <aLunR_0BPCrATnBP@google.com>
References: <20250905222656.3692837-1-nkapron@google.com>
 <CAHC9VhT8NrsXMM-PPZJ0EPLxFHQ1vOu+ASCd+82Xth_mJPnDiA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhT8NrsXMM-PPZJ0EPLxFHQ1vOu+ASCd+82Xth_mJPnDiA@mail.gmail.com>

On Fri, Sep 05, 2025 at 10:13:01PM -0400, Paul Moore wrote:
> 
> With the original patch sitting at the top of the selinux/dev branch,
> are you okay if I simply fixup the existing patch by adding the
> missing '!'?
>

Yes, that is fine by me. I could submit a v4 if you would prefer that.

Sorry for the thrash,
Neill

