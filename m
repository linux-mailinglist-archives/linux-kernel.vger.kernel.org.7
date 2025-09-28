Return-Path: <linux-kernel+bounces-835435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85458BA715C
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 16:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16906177A23
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 14:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888AE212549;
	Sun, 28 Sep 2025 14:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pWef6/N6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD90E2F2E;
	Sun, 28 Sep 2025 14:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759068542; cv=none; b=tlRCmhTfGta7YkXOuwEwIHKf9DDp81DrTD+WGLN13k8xpijtn8Z1QpNOShCcPTd1to2IlevXs3P6xUCdXUBJireG6Xe7czngZqVuLeAzyjRJOAUj8kmjc3BHWjvg4+kTLuiY2d13cJjzBCnIdMSEUFM4wzFB+aYOxcdvZMIXdOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759068542; c=relaxed/simple;
	bh=oLopCkmGri793JE1kd5+sWMGisCseqI+NsmBu5y90K8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ByMQqOrgmklXBFG5OrToZD7REXlfEv9aN3nC8FdscWEi29kEt7TXrB5/1tsBXGQElbvA8LQDijhQcbiz1FG9jsqmYe0ZUwq90parFPhHkSHjV80sg2b933XfKGgPgRDii2MblXBuTOGhBW//kZgGE7Ti/4TASzNo2XvY/GVtSk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pWef6/N6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4016C4CEF0;
	Sun, 28 Sep 2025 14:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759068542;
	bh=oLopCkmGri793JE1kd5+sWMGisCseqI+NsmBu5y90K8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pWef6/N61eoFufqCle9xI0T0DU1bauI9krI9XxIo4sI9ZseI9gcbbjFFi85JiVBWr
	 Q9j6FIA0BDuoMchOPOT45kc3k+akgS6Sg4iLtLIRzFv7D4eRCKzAmPobCJsOTPNn3m
	 pTcS3BoqIJHTA8qrudy3uv1tjeVATtPSfcZ5htEpV+INz42ZaIhk0vULPa9+OJ69MZ
	 D/bYvDjucs1IZi9Ff7HIRr5UoXOsM0UNBjQdfrFdHNIBnS4GXv+XYPkCJGWuh2xUZA
	 f4lEbio8+Vt1GziYj++Ta3tzjnqYUtkCZ/F78PzZUzi7pOXAtgRcdWbIYrT0JlRFbP
	 l1TlMqccYnL7g==
Date: Sun, 28 Sep 2025 17:08:57 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: linux-kernel@vger.kernel.org, pasha.tatashin@soleen.com,
	Cong Wang <cwang@multikernel.io>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Changyuan Lyu <changyuanl@google.com>, kexec@lists.infradead.org,
	linux-mm@kvack.org, multikernel@lists.linux.dev
Subject: Re: [RFC Patch 0/7] kernel: Introduce multikernel architecture
 support
Message-ID: <aNlBeSpNCvqKXBWm@kernel.org>
References: <20250918222607.186488-1-xiyou.wangcong@gmail.com>
 <aNZWTB_AbK1qtacy@kernel.org>
 <CAM_iQpWBHWscTbuUm54G3tvqf-EQhSYaFJqEJD4M73doeH=TKQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM_iQpWBHWscTbuUm54G3tvqf-EQhSYaFJqEJD4M73doeH=TKQ@mail.gmail.com>

On Sat, Sep 27, 2025 at 01:27:04PM -0700, Cong Wang wrote:
> On Fri, Sep 26, 2025 at 2:01 AM Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >
> > On Thu, Sep 18, 2025 at 03:25:59PM -0700, Cong Wang wrote:
> > > This patch series introduces multikernel architecture support, enabling
> > > multiple independent kernel instances to coexist and communicate on a
> > > single physical machine. Each kernel instance can run on dedicated CPU
> > > cores while sharing the underlying hardware resources.
> > >
> > > The multikernel architecture provides several key benefits:
> > > - Improved fault isolation between different workloads
> > > - Enhanced security through kernel-level separation
> > > - Better resource utilization than traditional VM (KVM, Xen etc.)
> > > - Potential zero-down kernel update with KHO (Kernel Hand Over)
> >
> > This list is like asking AI to list benefits, or like the whole cover
> > letter has that type of feel.
> 
> Sorry for giving you that feeling. Please let me know how I can
> improve it for you.

There is no evidence of any of these benefits. That's the central
issue. You pretty much must give quantatitve proof of any of these
claims or the benefit is imaginary.

> 
> >
> > I'd probably work on benchmarks and other types of tests that can
> > deliver comparative figures, and show data that addresses workloads
> > with KVM, namespaces/cgroups and this, reflecting these qualities.
> 
> Sure, I think performance comes after usability, not vice versa.
> 
> 
> >
> > E.g. consider "Enhanced security through kernel-level separation".
> > It's a pre-existing feature probably since dawn of time. Any new layer
> > makes obviously more complex version "kernel-level separation". You'd
> > had to prove that this even more complex version is more secure than
> > pre-existing science.
> 
> Apologize for this. Do you mind explaining why this is more complex
> than the KVM/Qemu/vhost/virtio/VDPA stack?

KVM does not complicate kernel level separation or access control per
kernel instance at all. A guest in the end of the day is just a fancy
executable.

This feature on the other hand intervenes various easily breaking code
paths.

> 
> >
> > kexec and its various corner cases and how this patch set addresses
> > them is the part where I'm most lost.
> 
> Sorry for that. I will post Youtube videos to explain kexec in detail,
> please follow our Youtube channel if you are interested. (I don't
> want to post a link here in case people think I am promoting my
> own interest, please email me privately.)

Here I have to say that posting a youtube link to LKML is of your
own interest is not unacceptable as far as I'm concerned :-)

That said, I don't promise that I will watch any of the Youtube
videos posted either here or privately. All the quantitative
proof should be embedded to patches.

> 
> >
> > If I look at one of multikernel distros (I don't know any other
> > tbh) that I know it's really VT-d and that type of hardware
> > enforcement that make Qubes shine:
> >
> > https://www.qubes-os.org/
> >
> > That said, I did not look how/if this is using CPU virtualization
> > features as part of the solution, so correct me if I'm wrong.
> 
> Qubes OS is based on Xen:
> https://en.wikipedia.org/wiki/Qubes_OS


Yes, and it works great, and has much stronger security metrics than
this could ever reach, and that is quantitative fact, thanks to great
technologies such as VT-d :-)

This is why I'm repeating the requirement for quantitative proof. We
have already great solutions to most what this can do so building
evidence of usefulness is the huge stretch this patch set should
make it.

Nothing personal, but with the current basically just claims, I don't
believe in this. That said, by saying this I don't I'd pick my soccer
no. If there is enough evidence, I'm always ready to turn my opinion
180 degrees.

> 
> >
> > I'm not entirely sure whether this is aimed to be alternative to
> > namespaces/cgroups or vms but more in the direction of Solaris Zones
> > would be imho better alternative at least for containers because
> > it saves the overhead of an extra kernel. There's also a patch set
> > for this:
> >
> > https://lwn.net/Articles/780364/?ref=alian.info
> 
> Solaris Zones also share a single kernel. Or maybe I guess
> you meant Kernel Zones? Isn't it a justification for our multikernel
> approach for Linux? :-)
> 
> BTW, it is less flexible since it completely isolates kernels
> without inter-kernel communication. With our design, you can
> still choose not to use inter-kernel IPI's, which turns dynamic
> into static.
> 
> >
> > VM barrier combined with IOMMU is pretty strong and hardware
> > enforced, and with polished configuration it can be fairly
> > performant (e.g. via page cache bypass and stuff like that)
> > so really the overhead that this is fighting against is
> > context switch overhead.
> >
> > In security I don't believe this has any realistic chances to
> > win over VMs and IOMMU...
> 
> I appreciate you sharing your opinions. I hope my information
> helps.

I'd put strong focus on getting the figures aside with the claims :-)

> 
> Regards,
> Cong Wang

BR, Jarkko

